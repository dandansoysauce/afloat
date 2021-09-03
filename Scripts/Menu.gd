extends Node

onready var how_to = preload("res://Scenes/HowTo.tscn")
var how_to_file = "user://afloat-howto.save"
var first_user = true
var play_games_services

func _ready():
	$Admob.load_banner()
	$Admob.load_interstitial()
	load_howto()
	
	if (OS.get_name() == "Android"):
		if Engine.has_singleton("PlayGameServices"):
			play_games_services = Engine.get_singleton("PlayGameServices")
			play_games_services.init(get_instance_id(), true, false)

func _on_PlayButton_pressed():
	save_howto()
	if (first_user):
		get_tree().change_scene_to(how_to)
	else:
		get_tree().change_scene_to(Globals.game_scene)

func _on_ExitButton_pressed():
	get_tree().quit()

func load_howto():
	var file = File.new()
	if (file.file_exists(how_to_file)):
		file.open(how_to_file, File.READ)
		first_user = false
		file.close()
	else:
		first_user = true
		
func save_howto():
	var file = File.new()
	file.open(how_to_file, File.WRITE)
	file.store_var(false)
	file.close()

func _on_Admob_banner_loaded():
	$Admob.hide_banner()

func _on_Login_pressed():
	if (play_games_services):
		play_games_services.sign_in()

func _on_Leaderboards_pressed():
	play_games_services.show_leaderboard(Constants.PPG_LEADER_ID)
