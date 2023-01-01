local Janitor = require(script.Parent.Janitor)

export type SuperAttribute = {
	new: (Object: Instance) -> ({},{},{});
}

local SuperAttribute: SuperAttribute = {}

function SuperAttribute.new(Object: Instance)
	assert(typeof(Instance) == "Instance", "Object must be an Instance!")

	local __Janitor = Janitor.new()
	__Janitor:LinkToInstance(Object)

	local self = setmetatable({
		__Instance__ = Object;
		__Janitor__ = __Janitor;
		__Private__ = setmetatable({
			__Storage__ = {};
			__RegisteredValues__ = {};
		},{
			__newindex = function(self, Index: string, Value: any)
				assert(type(Index) == "string", "Index has to be a string!")

				if not (self.__RegisteredValues__[Index]) then
					self.__RegisteredValues__[Index] = true
				end

				self.__Storage__[Index] = Value
			end;
			__index = function(self, Index: string)
				return self.__Storage__[Index]
			end;
		});
		__ReadOnly__ = setmetatable({
			__props__ = {};
			__LastValues__ = {};
			__RegisteredValues__ = {};
		},{
			__newindex = function(self, Index: string, Value: any)
				assert(type(Index) == "string", "Index has to be a string!")

				if not (self.__RegisteredValues__[Index]) then
					self.__RegisteredValues__[Index] = true
				end

				if not (self.__props__.__AttributeChangedConnection__) then
					self.__props__.__AttributeChangedConnection__ = __Janitor:Add(Object.AttributeChanged:Connect(function(Name: string)
						if not (self.__RegisteredValues__[Name]) then return end
						if (self[Name] == self.__LastValues__[Name]) then return end

						self[Name] = self.__LastValues__[Name]
					end))
				end

				self.__LastValues__[Index] = Value
				Object:SetAttribute(Index, Value)
			end;
			__index = function(self, Index: string)
				return Object:GetAttribute(Index)
			end;
		});
	},SuperAttribute)

	return self, self.__Private__, self.__ReadOnly__
end

function SuperAttribute:__newindex(Index: string, Value: any)
	assert(type(Index) == "string", "Index has to be a string!")

	if (self.__Private__.__RegisteredValues__[Index]) then
		self.__Private__[Index] = Value
		return
	end

	if (self.__ReadOnly__.__RegisteredValues__[Index]) then
		self.__ReadOnly__.__LastValues__[Index] = Value
	end

	self.__Instance__:SetAttribute(Index, Value)
end

function SuperAttribute:__index(Index: string)
	assert(type(Index) == "string", "Index has to be a string!")

	return self.__Private__[Index] or self.__ReadOnly__[Index] or self.__Instance__:GetAttribute(Index)
end

return SuperAttribute :: SuperAttribute