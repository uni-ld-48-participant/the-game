extends KinematicBody2D

export (int) var speed = 50
export (int) var jump_speed = -200
export (int) var gravity = 4000
export (int) var steps = 200
export (String) var nick = "Woomper"

var idleStep = 0
var stepDelta = 0
var consume_delta = 0

var campFireArea: Area2D = null
var mushroomArea: RigidBody2D = null


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
	if mushroomArea != null && mushroomArea.position.x > 0:
		goal_position = mushroomArea.position.x
	elif campFireArea != null && campFireArea.position.x > 0:
		goal_position = campFireArea.position.x
	
	if (idleStep > steps/2 - 1 && goal_position == -1) || (position.x < goal_position):
		idleStep = (idleStep + 1) % steps
		return speed
	else:
		idleStep = (idleStep + 1) % steps
		return -speed

func consume_mushroom(delta):
	consume_delta += delta
	if mushroomArea != null && abs(mushroomArea.global_position.x - self.global_position.x) < 60 && consume_delta > 1 :
		consume_delta = 0
		$Woomp.play()
		mushroomArea.consume()

func _on_Area2D_area_entered(area):
	if area.is_in_group("campfire"):
		print("I collided with campfire")
		campFireArea = area as Area2D


func _on_Area2D_body_entered(body):
	if body.is_in_group("mushroom"):
		print("I collided with campfire")
		mushroomArea = body as RigidBody2D
