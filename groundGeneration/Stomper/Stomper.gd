extends KinematicBody2D

export (int) var speed = 200
export (int) var jump_speed = -800
export (int) var gravity = 4000

export var mushrooms: int = 50
export var campfires: int = 50

signal mushrooms_signal(count)
signal campfire_signal(count)

var velocity = Vector2.ZERO


var stomping_delta: float = 0
var stomping_direction: int = 0

func _ready():
	emit_signal("campfire_signal", campfires)
	emit_signal("mushrooms_signal", mushrooms)

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		
func _physics_process(delta):
	place_fire()
	place_mushroom()
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed
	pick_up_mushroom()
	var isStomp = false
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider is TileMap:
			var tile_pos = collision.collider.world_to_map(position)
			if Input.is_action_just_pressed("ui_down"):
				if is_on_floor():
					print("Trying stomp on: ", tile_pos)
					stomping_direction = 0
					isStomp = stomp(collision.collider.get_parent().get_tile(tile_pos.x, tile_pos.y + 1))
			if Input.is_action_just_pressed("ui_left"):
					print("Trying stomp on: ", tile_pos)
					stomping_direction = 1
					isStomp = stomp(collision.collider.get_parent().get_tile(tile_pos.x - 1, tile_pos.y))
			if Input.is_action_just_pressed("ui_right"):
					print("Trying stomp on: ", tile_pos)
					stomping_direction = 2
					isStomp = stomp(collision.collider.get_parent().get_tile(tile_pos.x + 1, tile_pos.y))
	if stomping_delta < 1:
		if stomping_direction == 0:
			$AnimatedSprite.play("stomp_down")
		elif stomping_direction == 1:
			$AnimatedSprite.play("stomp_left")
		elif stomping_direction == 2:
			$AnimatedSprite.play("stomp_right")
	elif velocity.y < -50:
		$AnimatedSprite.play("jump")
	elif velocity.x > 20:
		$AnimatedSprite.play("move_right")
	elif velocity.x < -20:
		$AnimatedSprite.play("move_left")
	else:
		$AnimatedSprite.play("idle")
		
	check_stomping(delta)

func stomp(tile):
	if abs(velocity.x) < 50 && tile != null:
		if tile.hp < 30 && tile.type.cell_type == 4:
			campfires += 1
			emit_signal("campfire_signal", campfires)
		tile.hp -= 25
		stomping_delta = 0
		return true
	else:
		return false

func check_stomping(delta):
	if stomping_delta < 1:
		stomping_delta += delta
		if !$StompSound.playing:
			$StompSound.play()
		return true
	else:
		$StompSound.stop()
		return false

func place_fire():
	if Input.is_action_just_pressed("ui_campfire") && campfires > 0 && is_on_floor():
		campfires -= 1
		emit_signal("campfire_signal", campfires)
		print("It's a campfire")
		var campfire = load("res://Campfire/Campfire.tscn").instance()
		get_parent().add_child(campfire)
		campfire.global_position = self.global_position
		
func place_mushroom():
	if Input.is_action_just_pressed("ui_mushroom") && mushrooms > 0 && is_on_floor():
		mushrooms -= 1
		emit_signal("mushrooms_signal", mushrooms)
		print("It's a mushroom")
		var mushroom = load("res://Mushroom/Mushroom.tscn").instance()
		get_parent().add_child(mushroom)
		var placeDelta = 50
		if velocity.x < 0:
			placeDelta = -50
		mushroom.global_position = Vector2(self.global_position.x + placeDelta, self.global_position.y)
		
func pick_up_mushroom():
	if Input.is_action_just_pressed("ui_pickup"):
		var bodies = $Area2D.get_overlapping_bodies()
		print("Bodies is: ", bodies)
		for body in bodies:
			if body is KinematicBody2D && body.is_in_group("mushroom"):
				mushrooms += 1
				emit_signal("mushrooms_signal", mushrooms)
				body.queue_free()
