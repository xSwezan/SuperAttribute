local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SuperAttribute = require(ReplicatedStorage.Packages.MainModule)
local A, Private, ReadOnly = SuperAttribute.new(workspace.Baseplate)

A.Coins = 10
Private.LastCoins = 0
ReadOnly.CoinsPerSecond = 5
print(A.Coins)
task.wait(3)
print(A.CoinsPerSecond)
print(A.LastCoins)
Private.LastCoins = 10
A.Coins = 3
print(A.LastCoins)

print(A)