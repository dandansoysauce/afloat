extends KinematicBody2D

var speed = 500
var velocity : Vector2 = Vector2()

func _physics_process(delta):
	velocity.y += Constants.GRAVITY * delta
	velocity.x = speed

	if (self.position.y > get_viewport_rect().size.y):
		$Admob.show_interstitial()
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		
	if (Input.is_action_just_pressed("add_air")):
		flap()

	velocity = move_and_slide(velocity)
	
func flap():
	# velocity.y = Constants.JUMP_FORCE * 2
	if (Globals.airbags > 0):
		velocity.y = Constants.JUMP_FORCE
		Globals.airbags -= 1

func _on_Admob_interstitial_failed_to_load(error_code):
	$Admob.load_interstitial()
