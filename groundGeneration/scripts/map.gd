extends Node2D

const cavernMinWidth = 1
const cavernMaxWidth = 10
const cavernMinHeight = 1
const cavernMaxHeight = 5
const generationDepth = 100
const depth = 150
const screenWidth = 30

var rng_seed : int

func _process(delta):
	if Input.is_action_pressed("ui_restart"):
		restart()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$GameTileMap.init_scene(screenWidth, depth+1, Global.Empty)	

	generateTiles(depth-generationDepth, depth)
	setDipper(0, 0, screenWidth, depth, Global.Rock)
	setSquare(8, depth-generationDepth, 10, 2, Global.Empty)

func generateTiles(firstLine, lastLine):
	# generate map here

	rng_seed = 6
	#seed(rng_seed)
	randomize()

	# base fill
	setSquare(0, firstLine, screenWidth, lastLine - firstLine, Global.Dirt)
	
	# resources fill
	addTileType(firstLine, lastLine, Global.Metal)
	addTileType(firstLine, lastLine, Global.Rock)
	addTileType(firstLine, lastLine, Global.Coal)	
	addTileType(firstLine, lastLine, Global.Empty)

func addTileType(firstLine, lastLine, type):
	var currentDepth = firstLine
	while currentDepth < lastLine:
		var height = int(rand_range(cavernMinHeight, type.generation_max_height - cavernMinHeight))
		height = min(height, lastLine-currentDepth-type.vertcal_distance)
		
		var partsCount = int(rand_range(1, type.horizontal_limit))
		var segmentWidth = screenWidth / partsCount
		for i in range(partsCount):
			# fill one area
			var width = int(rand_range(cavernMinWidth, type.generation_max_width - cavernMinWidth))
			width = min(width, segmentWidth)
			var cavernStart = i*segmentWidth + int(rand_range(0, segmentWidth - width))
			setSquare(cavernStart, currentDepth, width, height, type)
			
		currentDepth = currentDepth + height + type.vertcal_distance

func setSquare(left, top, width, height, type):
	for y in range(top, top+height):
		for x in range(left, left + width):
				$GameTileMap.set_tile(x, y, type)
	if type == Global.Empty :
		placeMashrum((left+width/2)*40, (top+height/2-6)*40)

func setDipper(left, top, width, height, type):
	for y in range(top, top+height):
		$GameTileMap.set_tile(left, y, type)
		$GameTileMap.set_tile(left+width-1, y, type)
	for x in range(left, left+width):
		$GameTileMap.set_tile(x, top+height, type)
		$GameTileMap.set_tile(x, top, type)

func placeMashrum(x, y):
	var mushroom = load("res://Mushroom/Mushroom.tscn").instance()
	add_child(mushroom)
	mushroom.global_position = Vector2(x, y)
	
func restart():
	get_tree().reload_current_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
