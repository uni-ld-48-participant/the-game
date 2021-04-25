extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var fire_time = 20
export var heat_interval = 0.5

var localDelta = 0
var heat_delta = 0

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	localDelta += delta
	heat_delta += delta
	if localDelta > fire_time:
		queue_free()
	if heat_delta > heat_interval:
		_apply_heat()
		heat_delta = 0

func _apply_heat():
	var bodies = self.get_overlapping_bodies()
	if !bodies.empty():
		for body in bodies:
			if body is TileMap:
				var pos = body.world_to_map(self.position)
				var map = body.get_parent() as GameTileMap
				_apply_tile_heat(map.get_tile(pos.x, pos.y + 1))
				_apply_tile_heat(map.get_tile(pos.x, pos.y - 1))
				_apply_tile_heat(map.get_tile(pos.x + 1, pos.y))
				_apply_tile_heat(map.get_tile(pos.x - 1, pos.y))
					
func _apply_tile_heat(tile: GameTile):
	if tile == null:
		return		
	tile.temperature = min(tile.temperature + 4, 30)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
