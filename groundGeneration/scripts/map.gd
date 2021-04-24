extends Node2D

const cavernMinWidth = 3
const cavernMaxWidth = 20
const cavernMinHeight = 1
const cavernMaxHeight = 5
const generationDepth = 100
const screenWidth = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap.set_tile(0, 0, Global.TileTypes.Empty)
	$TileMap.set_tile(1, 0, Global.TileTypes.Dirt)
	$TileMap.set_tile(2, 0, Global.TileTypes.Rock)
	$TileMap.set_tile(3, 0, Global.TileTypes.Metal)
	$TileMap.set_tile(4, 0, Global.TileTypes.Coal)
	$TileMap.set_tile(5, 0, Global.TileTypes.Ice)

	generateTiles(10, generationDepth)

func generateTiles(firstLine, lastLine):
		# generate map here
	var width = 0
	var height = 0
	var currentDepth = firstLine
	
	while currentDepth < lastLine:
		width = (randi() % (cavernMaxWidth - cavernMinWidth) + cavernMinWidth)
		height = (randi() % (cavernMaxHeight - cavernMinHeight) + cavernMinHeight)
		var cavernStart = (randi() % (screenWidth - width - 1))
		
		# set tiles
		for x in range(0, screenWidth):
			for y in range(currentDepth, currentDepth+height):
				if(x > cavernStart and x < cavernStart + width):

					$TileMap.set_tile(x, y, Global.TileTypes.Empty)
				else:
					$TileMap.set_tile(x, y, Global.TileTypes.Dirt)
		
		currentDepth = currentDepth + height

	$TileMap.set_tile(22, 22, Global.TileTypes.Ice)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
