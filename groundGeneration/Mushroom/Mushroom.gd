extends KinematicBody2D

export var hitpoints = 100
export (int) var gravity = 8000



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	$Label.text = str(hitpoints)
	if hitpoints < 10:
		queue_free()	

func _physics_process(delta):
	var velocity = Vector2(0, gravity)
	move_and_slide(velocity, Vector2.UP)

func consume():
	hitpoints -= 10
	if hitpoints % 20 == 0:
		$AnimatedSprite.frame += 1
