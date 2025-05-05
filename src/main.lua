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

local function join_list(list, separator)
    local str = ""
    for i, item in ipairs(list) do
        str = str .. item
        if i < #list then
            str = str .. separator
        end
    end
    return str
end

if choice and recipes[choice] then
    local selected = recipes[choice]
    print("You have selected: " .. selected.name)
    local ingredients = selected.ingredients
    if type(ingredients) == 'table' then
        print("Ingredients: " .. join_list(ingredients, ', '))
    else
        print("Ingredients: " .. (selected.ingredients or "N/A"))
    end
    print("\nWould you like to see instructions? (y/n)")
    local see_instructions = io.read()

    if see_instructions:lower() == "y" then
        if selected.instructions then
            print("\nInstructions: \n" .. selected.instructions)
        else
            print("\nInstructions Not Available")
        end
    else
        print("\nOk. No instructions shown.")
    end
else
    print("Invalid Selection.")
end

print("\nPress Enter or X to exit...")
local _ = io.read()
