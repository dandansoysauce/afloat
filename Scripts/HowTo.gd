extends Node2D

var main_game = load("res://Scenes/Game.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_tree().change_scene_to(main_game)
