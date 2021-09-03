extends Node

onready var pill = preload("res://Scenes/Enemies/Pill.tscn")
onready var parent = get_tree().get_root().get_node("Game")
onready var player = get_tree().get_root().get_node("Game/JetpackPlayer")
var rng = RandomNumberGenerator.new()

func _on_SpawnTimer_timeout():
	rng.randomize()
	var item = pill.instance()
	var jetpackPosition = player.get_position()
	var yLoc = rng.randf_range(jetpackPosition.y + 576, jetpackPosition.y - 288)
	var xLoc = rng.randf_range(jetpackPosition.x + 1024, jetpackPosition.x + 1536)
	item.set_position(Vector2(xLoc, yLoc))
	parent.add_child(item)
