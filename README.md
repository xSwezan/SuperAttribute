# Why should I use SuperAttribute?
SuperAttribute is really easy to use and is lightweight.
SuperAttribute will save alot of time when dealing with attributes in your projects because you don't have to deal with :SetAttribute and :GetAttribute.

You also get some extra features with SuperAttribute that the Roblox Engine currently does NOT support, like being able to use the arithmetic operators (+=, -=, *=, ...)
when using attributes. You also get access to Global, Private and ReadOnly attributes with SuperAttribute.

<h2>🧰 Installation</h2>
You can install SuperAttribute via:

* [Wally](https://wally.run/package/xswezan/superattribute)
* [GitHub](https://github.com/xSwezan/SuperAttribute)
* [Creator Marketplace](https://www.roblox.com/library/11745988747) <small>(*Not recommended, may not be latest version*)</small>

<h2>📕 Documentation</h2>

<small>*All the documentation needed is provided in this post!*</small>

<h2>📝 Usage</h2>

This Library is **VERY** easy to use.

To create an AttributeClass, you simply use the `.new` method `SuperAttribute.new(Instance)`. The first argument is the Instance you want to bind the attributes with.

The `SuperAttribute.new()` returns 3 values:
* **Global** (Where you'll set and get GLOBAL (regular) attributes, they will show up as normal attributes in the attributes tab)
* **Private** (Where you'll set and get PRIVATE attributes, saved in the AttributeClass, they will NOT show up in the attributes tab)
* **ReadOnly** (Where you'll set and get READONLY attributes, the attribute is only readonly in the properties window and when other scripts try to change the value. It will show up in the attributes tab, but won't be editable from outside of the script)

All of the SuperAttributes can be accessed with the Global variable, but not the other way around.

<h4>An example of this</h4>

```lua
local Global, Private, ReadOnly = SuperAttribute.new(MyPickaxe)

-- Global Example

Global.MineSpeed = 10

print(Global.MineSpeed) -- 10
print(ReadOnly.MineSpeed) -- nil
print(Private.MineSpeed) -- nil

-- ReadOnly Example

ReadOnly.ItemName = "Diamond Pickaxe"

print(Global.ItemName) -- "Diamond Pickaxe"
print(ReadOnly.ItemName) -- "Diamond Pickaxe"
print(Private.ItemName) -- nil

-- Private Example

Private.Debounce = false

print(Global.Debounce) -- false
print(ReadOnly.Debounce) -- nil
print(Private.Debounce) -- false
```

<h2>📋 Use Case Example</h2>

```lua
-- Get SuperAttribute
local SuperAttribute = require(PARENT.SuperAttribute)

-- Create a new Attribute Class
local Global, Private, ReadOnly = SuperAttribute.new(MyCar)

-- Now just create your attributes!

Global.MaxSpeed = 100 -- Regular Attribute, does show up in the attributes tab.
Private.HasDriver = false -- Private Attribute, does not show up in the attributes tab with the Properties Tab
ReadOnly.Throttle = true -- ReadOnly Attribute (SuperAttribute Exclusive), does show up in the attributes tab but can't be changed from the window, must be changed within the script.

print(Global.MaxSpeed) -- 100
print(Global.HasDriver) -- false

print(Global.Throttle) -- true
Attributes.Throttle = false
print(Global.Throttle) -- false

Global.MaxSpeed += 30
print(Global.MaxSpeed) -- 130
```

<small>TIP: You can also access a normal attribute that is not created via SuperAttribute. You can do so by indexing Global with the attribute name.</small>

Think of it as a normal variable, you can use the normal Lua operators and such.

SuperAttribute also supports arithmetic operators, which the Roblox Engine does not support when it comes to dealing with attributes

<h2>📋 Arithmetic Operators Example</h2>

```lua
-- This is the normal way to increment an attribute

Part:SetAttribute("Clicks", Part:GetAttribute("Clicks") + 1) -- 60 characters

-- This is the SuperAttribute way of doing the same thing

Global.Clicks += 1 -- 18  characters

-- This leaves us with an astonishing 70% code reduction!
```

Now this might seem like magic at first, but it really isn't. It's just a way to manage object attributes easier, with some extra features included.
