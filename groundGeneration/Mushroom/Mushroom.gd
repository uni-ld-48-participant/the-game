extends RigidBody2D

export var hitpoints = 100



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	$Label.text = str(hitpoints)
	if hitpoints < 0:
		queue_free()	

func consume():
	hitpoints -= 10
	if hitpoints % 20 == 0:
		$AnimatedSprite.frame += 1
