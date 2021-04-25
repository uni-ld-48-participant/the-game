extends Node2D
class_name GameTileMap

const TEMPERATURE_PROCESS_INTERVAL = 0.2
	
var tiles = []

func get_tile(x: int, y: int) -> GameTile:
	if x < 0 || x >= tiles.size() || y < 0 || y >= tiles[0].size():
		return null
	return tiles[x][y]

func set_tile(x: int, y: int, type: TileType):
	get_tile(x, y).type = type

func init_scene(size_x: int, size_y: int, type: TileType):
	clear()
	tiles = []
	tiles.resize(size_x)
	for x in range(0, size_x):
		tiles[x] = []
		tiles[x].resize(size_y)
		for y in range(0, size_y):
			tiles[x][y] = GameTile.new(x, y, type, $CellMap, $IceMap, $DmgMap)
	
func clear():
	for row in tiles:
		for tile in row:
			tile.clear()
	tiles.clear()

func _process_temperature():	
	for row in tiles:
		for tile in row:
			tile.exchange_temperature(get_tile(tile.x+1, tile.y))
			tile.exchange_temperature(get_tile(tile.x, tile.y+1))

	for row in tiles:
		for tile in row:
			tile.process_temerature()
	
var _time_since_last_process = 0
func _physics_process(delta):
	_time_since_last_process += delta
	if _time_since_last_process >= TEMPERATURE_PROCESS_INTERVAL:
		_process_temperature()
		_time_since_last_process = 0
