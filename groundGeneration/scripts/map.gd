extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const cavernMinWidth = 3
const cavernMaxWidth = 20
const cavernMinHeight = 1
const cavernMaxHeight = 5
const generationDepth = 1000
const screenWidth = 50

# Called when the node enters the scene tree for the first time.
func _ready():
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
					$TileMap.set_cell(x, y, 2)
				else:
					$TileMap.set_cell(x, y, 3)
		
		currentDepth = currentDepth + height

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
