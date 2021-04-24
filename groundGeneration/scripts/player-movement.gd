extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 1.0

var target_for_taasd
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
