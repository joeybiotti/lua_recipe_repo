package.path = package.path .. ";libs/?.lua"

local json = require("dkjson")

local function read_file(path)
    local f = io.open(path, "r")
    if not f then return nil, "Could not open file: " .. path end
    local content = f:read("*a")
    f:close()
    return content
end

local contents, err = read_file('./data/recipes.json') -- Fixed typo here
assert(contents, err)

local recipes, pos, decode_err = json.decode(contents, 1, nil)
assert(recipes, "Error parsing JSON:" .. (decode_err or "Unknown Er"))

for i, recipe in ipairs(recipes) do
    print(i .. ". " .. recipe.name)
end

print("\n Please select a number.")

local choice = io.read()

choice = tonumber(choice)

if choice and recipes[choice] then
    local selected = recipes[choice]
    print("You have selected: " .. selected.name)
else
    print("Invalid Selection.")
end
