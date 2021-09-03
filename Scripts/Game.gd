extends Node2D

var score_file = "user://afloat.save"
enum GameState { Running, GameOver }
var State = null

func _ready():
	$Admob.show_banner()
	load_score()
	State = GameState.Running
	if(State == GameState.Running):
		$HUD/Flaps.set_text(str(Globals.airbags))
		$HUD/Score.set_text(str(Globals.score))
		$ScoreTimer.start()

func _process(_delta):
	$HUD/Flaps.set_text(str(Globals.airbags))
	$HUD/CoinScore/Coins.set_text(str(Globals.coins))
	$HUD/RingScore/Rings.set_text(str(Globals.rings))
	$HUD/StarScore/Stars.set_text(str(Globals.stars))
	
func load_score():
	var file = File.new()
	if (file.file_exists(score_file)):
		file.open(score_file, File.READ)
		$HUD/Highscore.set_text(str(file.get_var()))
		load_default()
		file.close()
	else:
		Globals.score = 0
		
func load_default():
	Globals.score = 0
	Globals.airbags = 10.0
	Globals.score = 0
	Globals.coins = 0
	Globals.rings = 0
	Globals.stars = 0
	Globals.current_level = 1
	Globals.level_multiplier = 10

func _on_ScoreTimer_timeout():
	Globals.score += Globals.current_level
	$HUD/Score.set_text(str(Globals.score))

func _on_Admob_banner_failed_to_load(error_code):
	$Admob.load_banner()

func _on_Admob_interstitial_failed_to_load(error_code):
	$Admob.load_interstitial()

func _on_Home_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Menu.tscn")
