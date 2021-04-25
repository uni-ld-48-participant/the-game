extends Node2D

const cavernMinWidth = 1
const cavernMaxWidth = 20
const cavernMinHeight = 1
const cavernMaxHeight = 5
const generationDepth = 100
const screenWidth = 50

var rng_seed : int

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameTileMap.init_scene(50, 120, Global.Empty)
	
	$GameTileMap.set_tile(0, 0, Global.Empty)
	$GameTileMap.set_tile(1, 0, Global.Dirt)
	$GameTileMap.set_tile(2, 0, Global.Rock)
	$GameTileMap.set_tile(3, 0, Global.Metal)
	$GameTileMap.set_tile(4, 0, Global.Coal)

	generateTiles(10, 10+generationDepth)
	setDipper(0, 10, screenWidth, generationDepth, Global.Rock)

func generateTiles(firstLine, lastLine):
	# generate map here

	rng_seed = 1
	seed(rng_seed)
	#randomize()

	# base fill
	setSquare(0, firstLine, screenWidth, lastLine - firstLine, Global.Dirt)
	
	# resources fill
	addTileType(firstLine, lastLine, Global.Metal)
	addTileType(firstLine, lastLine, Global.Rock)
	addTileType(firstLine, lastLine, Global.Empty)
	addTileType(firstLine, lastLine, Global.Coal)
	
	for q in range(0, screenWidth):
		$GameTileMap.get_tile(q, firstLine).temperature = 0

func addTileType(firstLine, lastLine, type):
	var currentDepth = firstLine
	while currentDepth < lastLine:
		var width = int(rand_range(cavernMinWidth, type.generation_max_width - cavernMinWidth))
		var height = int(rand_range(cavernMinHeight, type.generation_max_height - cavernMinHeight))
		var cavernStart = int(rand_range(0, screenWidth - width - 1))
		
		height = min(height, lastLine-currentDepth-type.vertcal_distance)
		
		# fill one area
		setSquare(cavernStart, currentDepth, width, height, type)
		currentDepth = currentDepth + height + type.vertcal_distance

func setSquare(left, top, width, height, type):
	for y in range(top, top+height):
		for x in range(left, left + width):
				$GameTileMap.set_tile(x, y, type)

func setDipper(left, top, width, height, type):
	for y in range(top, top+height):
		$TileMap.set_tile(left, y, type)
		$TileMap.set_tile(left+width-1, y, type)
	for x in range(left, left+width):
		$TileMap.set_tile(x, top+height, type)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
