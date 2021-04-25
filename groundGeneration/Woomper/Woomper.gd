extends KinematicBody2D

export (int) var speed = 60
export (int) var jump_speed = -200
export (int) var gravity = 4000
export (int) var steps = 300
export (String) var nick = "Woomper"

var idleStep = 0
var stepDelta = 0
var consume_delta = 0
var search_delta = 0
var health_delta = 0
var health = 100
var isFrozen = false

var mushroom: KinematicBody2D = null
var campfire: Area2D = null


var velocity = Vector2.ZERO

func _ready():
	$Label.text = nick

		
func _physics_process(delta):
	velocity.x = idle_moving_x(delta)
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	$AnimatedSprite.flip_h = velocity.x < 0
	if consume_delta < 1:
		$AnimatedSprite.play("consume")
	elif velocity.x != 0 && velocity.y == 0:
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
	checkHealth(delta)

func idle_moving_x(delta):
	if isFrozen:
		return 0
	var goal_position = -1
	if search_delta > 1:
		var mushroom = getNearestMushroom(self.position)
		var campfire = getNearestCampfire(self.position)
		search_delta = 0
	search_delta += delta
	if is_instance_valid(mushroom) && mushroom.position.x > 0:
		goal_position = mushroom.position.x
	elif is_instance_valid(campfire) && campfire.position.x > 0:
		goal_position = campfire.position.x
	
	if (idleStep > steps/2 - 1 && goal_position == -1) || (position.x < goal_position):
		idleStep = (idleStep + 1) % steps
		return speed
	else:
		idleStep = (idleStep + 1) % steps
		return -speed

func getNearestMushroom(myPosition: Vector2):
	var bodies = $Area2D.get_overlapping_bodies()
	if bodies.empty():
		mushroom = null
	else:
		for body in bodies:
			if body is KinematicBody2D && body.is_in_group('mushroom'):
				if mushroom == null || !is_instance_valid(mushroom):
					mushroom = body
				elif abs(mushroom.position.x - myPosition.x) > abs(body.position.x - myPosition.x):
					mushroom = body
	if is_instance_valid(mushroom):
		if abs(mushroom.position.y - myPosition.y) > 100:
			mushroom = null
	return mushroom
	
func getNearestCampfire(myPosition: Vector2):
	var bodies = $Area2D.get_overlapping_areas()
	if bodies.empty():
		campfire = null
	else:
		for body in bodies:
			if body is KinematicBody2D && body.is_in_group('campfire'):
				if campfire == null || !is_instance_valid(campfire):
					campfire = body
				elif abs(campfire.position.x - myPosition.x) > abs(campfire.position.x - myPosition.x):
					campfire = body
	if is_instance_valid(campfire):
		if abs(campfire.position.y - myPosition.y) > 100:
			campfire = null
	return campfire

func consume_mushroom(delta):
	consume_delta += delta
	var mushroom = getNearestMushroom(self.position)
	if is_instance_valid(mushroom) && abs(mushroom.position.x - self.position.x) < 60 && abs(mushroom.position.y - self.position.y) < 30 && consume_delta > 1 :
		consume_delta = 0
		$Woomp.play()
		mushroom.consume()

func _on_Area2D_area_entered(area):
	if area.is_in_group("campfire"):
		print("I collided with campfire")


func _on_Area2D_body_entered(body):
	if body.is_in_group("mushroom"):
		print("I collided with mushroom")
		$Mushroom.play()
			
func checkHealth(delta):
	if health_delta < 1:
		health_delta += delta
		return
	$Label.text = nick + " " + str(health)
	health_delta = 0
	if health < 10:
		frozen()
	var bodies = $Area2D.get_overlapping_bodies()
	for body in bodies:
		if body is TileMap:
			checkNearTiles(body.world_to_map(self.position), body)
			
func checkNearTiles(position: Vector2, tileMap: TileMap):
	var tile = tileMap.get_parent().get_tile(position.x, position.y + 1)
	print("Tile is ", tile)
	if tile != null && tile.temperature < 8:
		self.health -= 10
		$Ouch.play()
		
func frozen():
	isFrozen = true
