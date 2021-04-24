extends TileMap
const TEMPERATURE_PROCESS_INTERVAL = 0.5
const CELL_NEIGHBOR = [[-1,0],[1,0],[0,-1],[0,1]]


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var tileInfos = {}

func reset_tile(x: int, y: int):
	set_tile(x, y, tileInfos[x][y])

func set_tile(x: int, y: int, tile):
	$ShadeMap.set_cell(x, y, 0 if tile.temperature == 0 else 1)
	self.set_cell(x, y, tile.type)
	if !tileInfos.has(x):
		tileInfos[x] = {}
	tileInfos[x][y] = tile

func _process_temperature():
	for x in tileInfos:
		for y in tileInfos[x]:
			var tile = tileInfos[x][y]
			if tile.type == 3 && _is_near_cold(x, y):
				tile.next_temperature = 0
	_apply_next_temperature()
				
func _apply_next_temperature():
	for x in tileInfos:
		for y in tileInfos[x]:
			var tile = tileInfos[x][y]
			if tile.has('next_temperature'):
				tile.temperature = tile.next_temperature
				tile.erase('next_temperature')
				reset_tile(x, y)

func _is_near_cold(x, y) -> bool:
	for delta in CELL_NEIGHBOR:
		var dx = x + delta[0]
		var dy = y + delta[1]
		if(tileInfos.has(dx) &&
			tileInfos[dx].has(dy) &&
			tileInfos[dx][dy].temperature == 0):
			return true
	return false
	
var _time_since_last_process = 0
func _physics_process(delta):
	_time_since_last_process += delta
	if _time_since_last_process >= TEMPERATURE_PROCESS_INTERVAL:
		_process_temperature()
		_time_since_last_process = 0
