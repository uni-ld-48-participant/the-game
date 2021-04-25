extends KinematicBody2D

export (int) var speed = 50
export (int) var jump_speed = -200
export (int) var gravity = 4000
export (int) var steps = 200
export (String) var nick = "Woomper"

var idleStep = 0
var stepDelta = 0
var consume_delta = 0

var mushroomArray = []
var campFireArray = []


var velocity = Vector2.ZERO

func _ready():
	$Label.text = nick

		
func _physics_process(delta):
	velocity.x = idle_moving_x(delta)
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	$AnimatedSprite.flip_h = velocity.x < 0
	if velocity.x != 0 && velocity.y == 0:
		$AnimatedSprite.play("move")
	else:
		$AnimatedSprite.play("idle")
	
	if velocity.x == 0 && velocity.y == 0 && stepDelta > 0.5:
		stepDelta = 0
		if idleStep > steps/2:
			idleStep = 0
		else:
			idleStep = steps/2
	stepDelta += delta
	
	consume_mushroom(delta)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
			
		if collision.collider is TileMap:
			var tile_pos = collision.collider.world_to_map(position)
			tile_pos -= collision.normal
			var tile_id = collision.collider.get_cellv(tile_pos)
			#print("I collided with ", tile_id)

func idle_moving_x(delta):
	var goal_position = -1
	var mushroom = getNearestMushroom(self.position)
	var campfire = getNearestCampfire(self.position)
	if mushroom != null && mushroom.position.x > 0:
		goal_position = mushroom.position.x
	elif campfire != null && campfire.position.x > 0:
		goal_position = campfire.position.x
	
	if (idleStep > steps/2 - 1 && goal_position == -1) || (position.x < goal_position):
		idleStep = (idleStep + 1) % steps
		return speed
	else:
		idleStep = (idleStep + 1) % steps
		return -speed

func getNearestMushroom(myPosition: Vector2):
	if !mushroomArray.empty():
		var mushroom = mushroomArray[0]
		for item in mushroomArray:
			if item == null:
				mushroomArray.erase(item)
			elif mushroom != null && abs(item.position.x - myPosition.x) <  abs(mushroom.position.x - myPosition.x):
				mushroom = item
			else:
				mushroom = item
		return mushroom
	else:
		return null
	
func getNearestCampfire(myPosition: Vector2):
	if !campFireArray.empty():
		var campfire = campFireArray[0]
		for item in campFireArray:
			if abs(item.position.x - myPosition.x) <  abs(campfire.position.x - myPosition.x):
				campfire = item
		return campfire
	else:
		return null

func consume_mushroom(delta):
	consume_delta += delta
	var mushroom = getNearestMushroom(self.position)
	if mushroom != null && abs(mushroom.position.x - self.position.x) < 60 && consume_delta > 1 :
		consume_delta = 0
		$Woomp.play()
		mushroom.consume()

func _on_Area2D_area_entered(area):
	if area.is_in_group("campfire"):
		print("I collided with campfire")
		if !campFireArray.has(area):
			campFireArray.append(area as Area2D)


func _on_Area2D_body_entered(body):
	if body.is_in_group("mushroom"):
		print("I collided with campfire")
		if !mushroomArray.has(body):
			mushroomArray.append(body as RigidBody2D)
