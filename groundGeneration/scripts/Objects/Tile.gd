extends Object

var x:int
var y:int
var type: TileType
var temperature:int
var hp:int
var label:Label
var map:TileMap

func _init(x:int, y:int, type:TileType, map:TileMap):
	self.x=x
	self.y=y
	self.type=type	

func _reset_stats():
	temperature = type.temperature
	hp = type.durability

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
