extends Node2D

const TileType = {
	Empty = 0,
	Dirt = 1,

	Rock = 2,
	Metal = 3,
	Coal = 4,
	Ice = 5
	
#	Rock = 4,
#	Metal = 5,
#	Coal = 6,
#	Ice = 7
}

const cavernMinWidth = 3
const cavernMaxWidth = 20
const cavernMinHeight = 1
const cavernMaxHeight = 5
const generationDepth = 100
const screenWidth = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap.set_cell(0, 0, TileType.Empty)
	$TileMap.set_cell(1, 0, TileType.Dirt)
	$TileMap.set_cell(2, 0, TileType.Rock)
	$TileMap.set_cell(3, 0, TileType.Metal)
	$TileMap.set_cell(4, 0, TileType.Coal)
	$TileMap.set_cell(5, 0, TileType.Ice)

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
					$TileMap.set_tile(x, y, { "type": TileType.Empty, "temperature": 1 })
				else:
					$TileMap.set_tile(x, y, { "type": TileType.Dirt, "temperature": 1 })
		
		currentDepth = currentDepth + height

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
