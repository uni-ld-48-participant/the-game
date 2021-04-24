extends TileMap
const TEMPERATURE_PROCESS_INTERVAL = 0.5
const TEMPERATURE_THREASHHOLD = 0.9
const CELL_NEIGHBOR = [[-1,0],[1,0],[0,-1],[0,1]]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tile_data = {}

func get_tile(x: int, y: int):
	return tile_data[x][y] if tile_data.has(x) && tile_data[x].has(y) else null

func set_tile(x: int, y: int, type):
	if !tile_data.has(x):
		tile_data[x] = {}
	tile_data[x][y] = { 
		x = x,
		y = y,
		type = type, 
		temperature = type.temperature,
		hp = type.durability
	}
	apply_tile(tile_data[x][y])

func apply_tile(tile):
	$ShadeMap.set_cell(tile.x, tile.y, 0 if tile.temperature == 0 else 1)
	self.set_cell(tile.x, tile.y, tile.type.cell_type)

func _process_temperature():
	for x in tile_data:
		for y in tile_data[x]:
			var tile = get_tile(x, y)
			var baseTemp = tile.temperature
			_exchange_temperature(tile, get_tile(x+1, y))
			_exchange_temperature(tile, get_tile(x, y+1))
			if tile.temperature < TEMPERATURE_THREASHHOLD:
				tile.temperature = 0
			#if abs(baseTemp - tile.temperature) > TEMPERATURE_THREASHHOLD:
			apply_tile(tile)

func _exchange_temperature(tileA, tileB):
	if tileA == null || tileB == null:
		return
	var delta = (tileA.temperature - tileB.temperature) / 5
	
	if delta > 0:
		var q = 3

	if !tileA.type.static:
		tileA.temperature -= delta
		
	if !tileB.type.static:
		tileB.temperature += delta

func _is_near_cold(x, y) -> bool:
	for delta in CELL_NEIGHBOR:
		var dx = x + delta[0]
		var dy = y + delta[1]
		if(tile_data.has(dx) &&
			tile_data[dx].has(dy) &&
			tile_data[dx][dy].temperature == 0):
			return true
	return false
	
var _time_since_last_process = 0
func _physics_process(delta):
	_time_since_last_process += delta
	if _time_since_last_process >= TEMPERATURE_PROCESS_INTERVAL:
		_process_temperature()
		_time_since_last_process = 0
