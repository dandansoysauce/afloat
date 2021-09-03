extends Node

onready var bottle = preload("res://Scenes/Enemies/Bottle.tscn")
onready var knife = preload("res://Scenes/Enemies/Knife.tscn")
onready var cactus = preload("res://Scenes/Enemies/SmallCactus.tscn")
onready var parent = get_tree().get_root().get_node("Game")
onready var player = get_tree().get_root().get_node("Game/JetpackPlayer")
onready var enemies = [bottle, knife, cactus]
var rng = RandomNumberGenerator.new()

func _on_SpawnTimer_timeout():
	rng.randomize()
	var getEnemy = rng.randi() % 3
	var enemy = enemies[getEnemy].instance()
	var jetpackPosition = player.get_position()
	var yLoc = rng.randf_range(jetpackPosition.y + 576, jetpackPosition.y - 288)
	var xLoc = rng.randf_range(jetpackPosition.x + 1024, jetpackPosition.x + 1536)
	enemy.set_position(Vector2(xLoc, yLoc))
	parent.add_child(enemy)
