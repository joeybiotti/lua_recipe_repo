package.path = package.path .. ";libs/?.lua"

local json = require("dkjson")

local file = io.open("data/recipes.json", "r")
if not file then
    error("File not found.")
end
local file = io.open("data/recipes.json", "r")
if not file then
    error("File not found.")
end

local contents = file:read("*a")
file:close()

local recipes, pos, err = json.decode(contents, 1, nil)
assert(recipes, "Error parsing JSON: " .. (err or "unknown error"))

for i, recipe in ipairs(recipes) do
    print(i .. ". " .. recipe.name)
end
