# sets a lot of memory to one number
# { x: int, y: int, z: int, value: int, amount: int }

# x and amount are the two parameters that change, so we put them in a
# scoreboard here
scoreboard objectives add byteblocks_memset dummy
$scoreboard players set x byteblocks_memset $(x)
$scoreboard players set amount byteblocks_memset $(amount)

# end condition
execute if score amount byteblocks_memset matches 0 run return 1

# now we put the parameters in a storage to call the write function
$execute store result storage byteblocks:memset x int 1 run scoreboard players set tmp byteblocks_memset $(x)
$execute store result storage byteblocks:memset y int 1 run scoreboard players set tmp byteblocks_memset $(y)
$execute store result storage byteblocks:memset z int 1 run scoreboard players set tmp byteblocks_memset $(z)
$execute store result storage byteblocks:memset value int 1 run scoreboard players set tmp byteblocks_memset $(value)

# and here we call the write function
function byteblocks:write with storage byteblocks:memset

# now we change x and amount and update the storage for recursion
scoreboard players add x byteblocks_memset 1
scoreboard players remove amount byteblocks_memset 1
execute store result storage byteblocks:memset x int 1 run scoreboard players get x byteblocks_memset
execute store result storage byteblocks:memset amount int 1 run scoreboard players get amount byteblocks_memset

# and recurse
function byteblocks:memset with storage byteblocks:memset
