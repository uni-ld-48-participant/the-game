extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var played = false
func _on_IntroArea1_body_entered(body):
	if body.is_in_group("stomper") && !played:
		if get_parent().active_intro != null:
			get_parent().active_intro.stop()
		get_parent().active_intro = $Sound
		$Sound.play()
		played = true
