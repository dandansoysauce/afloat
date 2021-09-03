extends Node

onready var feather = preload("res://Scenes/Items/Feather.tscn")
onready var yellow_feather = preload("res://Scenes/Items/YellowFeather.tscn")
onready var parent = get_tree().get_root().get_node("Game")
onready var player = get_tree().get_root().get_node("Game/JetpackPlayer")
onready var items = [feather, yellow_feather]
var rng = RandomNumberGenerator.new()

func _on_SpawnTimer_timeout():
	rng.randomize()
	var getItem = rng.randi() % 2
	var jetpackPosition = player.get_position()
	var yLoc = rng.randf_range(jetpackPosition.y + 576, jetpackPosition.y - 288)
	var xLoc = rng.randf_range(jetpackPosition.x + 1024, jetpackPosition.x + 1536)
	var item = items[getItem].instance()
	item.set_position(Vector2(xLoc, yLoc))
	parent.add_child(item)
