extends TileMap
const TEMPERATURE_PROCESS_INTERVAL = 0.5


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var tileInfos = []

#func _init_tile_info():
#	self.get

func set_cell(x: int, y: int, tile: int, flip_x: bool = false, flip_y: bool = false, transpose: bool = false, autotile_coord: Vector2 = Vector2( 0, 0 )):
	.set_cell(x, y, tile)

var _x=0
var _y=0
func _process_temperature():
	_x+=1
	_y+=1
	$ShadeMap.set_cell(_x, _y, 0)
	#var used = self.get_used_cells()
	#for cell in used:
	#	$ShadeMap.set_cell(cell.x, cell.y, 1)

	

var _time_since_last_process = 0
func _physics_process(delta):
	_time_since_last_process += delta
	if _time_since_last_process >= TEMPERATURE_PROCESS_INTERVAL:
		_process_temperature()
		_time_since_last_process = 0
