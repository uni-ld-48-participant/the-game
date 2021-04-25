extends Node2D

const cavernMinWidth = 1
const cavernMaxWidth = 20
const cavernMinHeight = 1
const cavernMaxHeight = 5
const generationDepth = 100
const screenWidth = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameTileMap.init_scene(50, 120, Global.Empty)
	
	$GameTileMap.set_tile(0, 0, Global.Empty)
	$GameTileMap.set_tile(1, 0, Global.Dirt)
	$GameTileMap.set_tile(2, 0, Global.Rock)
	$GameTileMap.set_tile(3, 0, Global.Metal)
	$GameTileMap.set_tile(4, 0, Global.Coal)
	generateTiles(10, generationDepth)

func generateTiles(firstLine, lastLine):
	# generate map here

	# base fill
	setSquare(0, firstLine, screenWidth, lastLine - firstLine, Global.Dirt)
	
	# resources fill
	addTileType(firstLine, lastLine, Global.Metal)
	addTileType(firstLine, lastLine, Global.Rock)
	addTileType(firstLine, lastLine, Global.Empty)
	addTileType(firstLine, lastLine, Global.Coal)
	
	for q in range(0, screenWidth):
		$GameTileMap.get_tile(q,firstLine).temperature = 0

func addTileType(firstLine, lastLine, type):
	var currentDepth = firstLine
	while currentDepth < lastLine:
		var width = (randi() % (type.generation_max_width - cavernMinWidth) + cavernMinWidth)
		var height = (randi() % (type.generation_max_height - cavernMinHeight) + cavernMinHeight)
		var cavernStart = (randi() % (screenWidth - width - 1))
		
		# fill one area
		setSquare(cavernStart, currentDepth, width, height, type)
		currentDepth = currentDepth + height + type.vertcal_distance

func setSquare(left, top, width, height, type):
	for y in range(top, top+height):
		for x in range(left, left + width):
				$GameTileMap.set_tile(x, y, type)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
