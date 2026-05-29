-- many-roads for iii - boreal ground
print("many-roads v1.1")
local exclude_files = {'many-roads.lua', 'init.lua', 'lib.lua'}
local led_active = 4
local grid_size_x = grid_size_x()
local grid_size = grid_size_x * grid_size_y()
function index_to_coord(index)
    local x = ((index - 1) % grid_size_x) + 1
    local y = math.floor((index - 1) / grid_size_x) + 1
    return x, y
end
function coord_to_index(x, y)
    local i = x + ((y - 1) * (grid_size_x))
    return i
end
local exclude_lookup = {}
for i = 1, #exclude_files do
    exclude_lookup[exclude_files[i]] = true
end
local filtered_list = {}
for _, i in ipairs(fs_list_files()) do
    if i:match("%.lua$") and not exclude_lookup[i] and not i:match("^pset_") then
        if #filtered_list <= grid_size then
            table.insert(filtered_list, i)
        end
    end
end
local scripts = filtered_list
print('-------')
print('installed iii scripts:')
for i = 1, #scripts do
    print(i .. ': ' .. scripts[i])
end
grid_led_all(0)
for i = 1, #scripts do
    local x, y = index_to_coord(i)
    grid_led(x, y, led_active)
end
grid_refresh()
function event_grid(x, y, z)
    if z == 1 then
        local i = coord_to_index(x, y)
        print('loading ' .. i .. ': ' .. scripts[i])
        require(scripts[i])
    end
end