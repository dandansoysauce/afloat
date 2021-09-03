extends Node

onready var player_node = get_tree().get_root().get_node("Game/JetpackPlayer")
onready var score_timer = get_tree().get_root().get_node("Game/ScoreTimer")

func _process(_delta):
	if(player_node.is_inside_tree()):
		Globals.level_multiplier = 10
		Globals.current_level = 1
