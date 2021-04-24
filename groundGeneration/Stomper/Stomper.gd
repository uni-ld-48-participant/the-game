extends KinematicBody2D

export (int) var speed = 120
export (int) var jump_speed = -800
export (int) var gravity = 4000


var velocity = Vector2.ZERO

func _ready():
	pass # Replace with function body.

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		
func _physics_process(delta):
	place_fire()
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_speed
	$AnimatedSprite.flip_h = velocity.x < 0
	
func place_fire():
	if Input.is_action_just_pressed("ui_campfire"):
		print("It's a campfire")
		var campfire = load("res://Campfire/Campfire.tscn").instance()
		get_parent().add_child(campfire)
		campfire.global_position = self.global_position

