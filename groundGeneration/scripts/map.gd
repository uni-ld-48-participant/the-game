extends Node2D

const TileType = {
	Empty = 0,
	Dirt = 1,

	Rock = 2,
	Metal = 3,
	Coal = 4,
	Ice = 5
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

	# base fill
	setSquare(0, firstLine, screenWidth, lastLine - firstLine, { "type": TileType.Dirt, "temperature": 1 })
	
	# resources fill
	addTileType(firstLine, lastLine, { "type": TileType.Ice, "temperature": 1 })
	addTileType(firstLine, lastLine, { "type": TileType.Metal, "temperature": 1 })
	addTileType(firstLine, lastLine, { "type": TileType.Rock, "temperature": 1 })
	addTileType(firstLine, lastLine, { "type": TileType.Coal, "temperature": 1 })


func addTileType(firstLine, lastLine, type):
	var currentDepth = firstLine
	while currentDepth < lastLine:
		var width = (randi() % (cavernMaxWidth - cavernMinWidth) + cavernMinWidth)
		var height = (randi() % (cavernMaxHeight - cavernMinHeight) + cavernMinHeight)
		var cavernStart = (randi() % (screenWidth - width - 1))
		
		# fill one area
		setSquare(cavernStart, currentDepth, width, height, type)
		currentDepth = currentDepth + height

func setSquare(left, top, width, height, type):
	for y in range(top, top+height):
		for x in range(left, left + width):
				$TileMap.set_tile(x, y, type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
