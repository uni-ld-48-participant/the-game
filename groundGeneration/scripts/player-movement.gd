extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 1.0

var target_for_target = Vector2(1,0)
var distance_to_target = 0
export(NodePath) var pathToPlayer



# Called when the node enters the scene tree for the first time.
func _ready():
	var myPlayer =  get_node(pathToPlayer) as Node2D
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2(0,0)
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	
	direction = direction.normalized()
	
	
	move_and_collide(direction * speed)
	pass
