extends Object
class_name GameTile
const FREEZING_THRESHOLD = 5
const CONDUCTIVITY = 3

export var show_temps = false;
export var show_hp = true;

var x:int
var y:int
var type: TileType setget set_type
var temperature:int setget set_temp
var hp:int setget set_hp

var _temp_delta: int = 0
var label:Label
var cell_map: TileMap
var ice_map: TileMap
var dmg_map: TileMap

func _init(_x:int, _y:int, _type:TileType,
	_cell_map: TileMap, _ice_map: TileMap, _dmg_map: TileMap):
	x = _x
	y = _y
	type = _type
	cell_map = _cell_map
	ice_map = _ice_map
	dmg_map = _dmg_map
	if show_temps || show_hp:
		label = Label.new()
		label.set_position(Vector2(x*40+15,y*40+15))
		cell_map.add_child(label)
	_reset_stats()
	
func clear():
	if label != null:
		cell_map.remove_child(label)
		label.free()
	self.free()

func exchange_temperature(tile):
	if(tile == null || tile.type == Global.Empty || type == Global.Empty):
		return

	var delta = (temperature - tile.temperature) / 2
	if(delta == 0):
		return	

	if delta < -CONDUCTIVITY:
		delta = -CONDUCTIVITY
	elif delta > CONDUCTIVITY:
		delta = CONDUCTIVITY

	self._temp_delta -= delta		
	tile._temp_delta += delta

func _reset_stats():
	temperature = type.temperature
	hp = type.hp
	_render()

func _render():
	_render_hp()
	_render_temperature()
	cell_map.set_cell(x, y, type.cell_type)
	
func _render_hp():
	var percent_id = round((hp / type.hp) / 0.2)
	dmg_map.set_cell(x, y, percent_id)
	if show_hp:
		label.text = "%d" % hp

func _render_temperature():
	if type == Global.Empty || temperature > FREEZING_THRESHOLD:
		ice_map.set_cell(x, y, -1)
	else:
		var ice_id = 5 - round((FREEZING_THRESHOLD - temperature) / (FREEZING_THRESHOLD/5.0))
		ice_map.set_cell(x, y, ice_id)
	if show_temps:
		if type == Global.Empty:
			label.text = ""
		else:
			label.text = "%d" % temperature

func process_temerature():
	if _temp_delta != 0:
		self.temperature += _temp_delta
		_temp_delta = 0

func set_hp(new_hp: int):
	if hp == new_hp:
		return
	hp = new_hp	
	if hp <= 0:
		type = Global.Empty
	_render_hp()
	
func set_temp(new_temp: int):
	if temperature == 0 || temperature == new_temp:
		return
	temperature = max(new_temp, 0)
	_render_temperature()
	
func set_type(new_type: TileType):
	if type == new_type:
		return
	type = new_type
	_reset_stats()