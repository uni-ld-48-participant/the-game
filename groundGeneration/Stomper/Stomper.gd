extends KinematicBody2D

export (int) var speed = 120
export (int) var jump_speed = -800
export (int) var gravity = 4000


var velocity = Vector2.ZERO
var mushrooms: int = 5
var mushroomInZone: RigidBody2D = null

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
	place_mushroom()
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = jump_speed
	$AnimatedSprite.flip_h = velocity.x < 0
	pick_up_mushroom()
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider is TileMap:
			var tile_pos = collision.collider.world_to_map(position)
			if Input.is_action_just_pressed("ui_down"):
				if is_on_floor():
					print("Trying stomp on: ", tile_pos)
					stomp(collision.collider, collision.collider.get_tile(tile_pos.x, tile_pos.y + 1))
			if Input.is_action_just_pressed("ui_left"):
					print("Trying stomp on: ", tile_pos)
					stomp(collision.collider, collision.collider.get_tile(tile_pos.x - 1, tile_pos.y))
			if Input.is_action_just_pressed("ui_right"):
					print("Trying stomp on: ", tile_pos)
					stomp(collision.collider, collision.collider.get_tile(tile_pos.x + 1, tile_pos.y))

func stomp(tileMap: TileMap, tile):
	if velocity.x < speed/2 && tile != null:
		tile.hp -= 25
		tileMap.apply_tile(tile)
		print("New tile is ", tile)

func place_fire():
	if Input.is_action_just_pressed("ui_campfire"):
		print("It's a campfire")
		var campfire = load("res://Campfire/Campfire.tscn").instance()
		get_parent().add_child(campfire)
		campfire.global_position = self.global_position
		
func place_mushroom():
	if Input.is_action_just_pressed("ui_mushroom") && mushrooms > 0:
		mushrooms -= 1
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
			if body is RigidBody2D && body.is_in_group("mushroom"):
				mushrooms += 1
				body.queue_free()
