extends CanvasLayer

var score = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_KinematicBody2D_campfire_signal(count):
	$Campfires.text = "Campfires: " + str(count)


func _on_KinematicBody2D_mushrooms_signal(count):
	$Mushrooms.text = "Mushrooms: " + str(count)


func _on_Timer_timeout():
	score += 5
	$Score.text = "Score: " + str(score)
