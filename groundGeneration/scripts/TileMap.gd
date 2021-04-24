extends TileMap
const TEMPERATURE_PROCESS_INTERVAL = 2
const TEMPERATURE_THREASHHOLD = 0.9
const CELL_NEIGHBOR = [[-1,0],[1,0],[0,-1],[0,1]]
	
var tile_data = {}

func get_tile(x: int, y: int):
	return tile_data[x][y] if tile_data.has(x) && tile_data[x].has(y) else null


func set_tile(x: int, y: int, type):
	if !tile_data.has(x):
		tile_data[x] = {}
	
	var label
	if(tile_data[x].has(y)):
		label = tile_data[x][y].label
	else:
		label = Label.new()
		label.set_position(Vector2(x*40+15,y*40+15))
		add_child(label)
	tile_data[x][y] = { 
		x = x,
		y = y,
		type = type, 
		temperature = type.temperature,
		hp = type.durability,
		label = label
	}	
	apply_tile(tile_data[x][y])	

func apply_tile(tile):
	if tile.hp <= 0:
		tile.type = Global.TileTypes.Empty
		
	tile.label.text = "%.1f" % tile.temperature
		
	var isFrost = tile.temperature <= 0 && tile.type != Global.TileTypes.Empty
	$ShadeMap.set_cell(tile.x, tile.y, 0 if isFrost else 1)
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
	if(tileA == null || tileB == null || 
		tileA.temperature == tileB.temperature):
		return
	var delta = (tileA.temperature - tileB.temperature) / 3.0

	if !tileA.type.static:
		tileA.temperature -= delta
		
	if !tileB.type.static:
		tileB.temperature += delta
	
var _time_since_last_process = 0
func _physics_process(delta):
	_time_since_last_process += delta
	if _time_since_last_process >= TEMPERATURE_PROCESS_INTERVAL:
		_process_temperature()
		_time_since_last_process = 0
