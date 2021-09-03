extends Node

var score_file = "user://afloat.save"
var previous_score = 0
var sharer = null
var play_games_services

func _ready():
	if Engine.has_singleton("GodotShare"):
		sharer = Engine.get_singleton("GodotShare")
		
	if (OS.get_name() == "Android"):
		if Engine.has_singleton("PlayGameServices"):
			play_games_services = Engine.get_singleton("PlayGameServices")
			play_games_services.init(get_instance_id(), true, false)

	load_score()
	if (Globals.score > previous_score):
		play_games_services.submit_leaderboard_score(Constants.PPG_LEADER_ID, Globals.score)
		save_score()
	$Coins/CoinsScore.set_text(str(Globals.coins))
	$Rings/RingsScore.set_text(str(Globals.rings))
	$Stars/StarsScore.set_text(str(Globals.stars))
	$Score.set_text("= " + str(Globals.score))
	$AnimationPlayer.play("default")

func _on_PlayAgainButton_pressed():
	get_tree().change_scene_to(Globals.game_scene)

func _on_ExitButton_pressed():
	get_tree().quit()

func save_score():
	var file = File.new()
	file.open(score_file, File.WRITE)
	file.store_var(Globals.score)
	file.close()
	
func load_score():
	var file = File.new()
	if (file.file_exists(score_file)):
		file.open(score_file, File.READ)
		previous_score = file.get_var()
		file.close()
	else:
		previous_score = 0

func _on_ShareButton_pressed():
	get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	# Let two frames pass to make sure the screen was captured
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	# Retrieve the captured image
	var img = get_viewport().get_texture().get_data()
	
	var image_save_path = OS.get_user_data_dir() + "/tmp.png"
  
	# Flip it on the y-axis (because it's flipped)
	img.flip_y()
	
	img.save_png(image_save_path)
	
	if sharer != null:
		sharer.sharePic(image_save_path, "Image Sharing", "Sharing image with GodotShare", "It's a demo app for testing GodotShare. Do you like it?")

func _on_Home_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
