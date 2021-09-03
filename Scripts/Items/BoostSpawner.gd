extends Node

onready var egg = preload("res://Scenes/Items/Egg.tscn")
onready var yellow_egg = preload("res://Scenes/Items/YellowEgg.tscn")
onready var gold_feather = preload("res://Scenes/Items/GoldFeather.tscn")
onready var parent = get_tree().get_root().get_node("Game")
onready var player = get_tree().get_root().get_node("Game/JetpackPlayer")
onready var items = [egg, yellow_egg, gold_feather]
var rng = RandomNumberGenerator.new()

func _on_SpawnTimer_timeout():
	rng.randomize()
	var getItem = rng.randi() % 3
	var jetpackPosition = player.get_position()
	var yLoc = rng.randf_range(jetpackPosition.y + 576, jetpackPosition.y - 288)
	var xLoc = rng.randf_range(jetpackPosition.x + 1024, jetpackPosition.x + 1536)
	var item = items[getItem].instance()
	item.set_position(Vector2(xLoc, yLoc))
	parent.add_child(item)
