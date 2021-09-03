extends Node

onready var star = preload("res://Scenes/Items/Star.tscn")
onready var ring = preload("res://Scenes/Items/Ring.tscn")
onready var coin = preload("res://Scenes/Items/Coin.tscn")
onready var parent = get_tree().get_root().get_node("Game")
onready var player = get_tree().get_root().get_node("Game/JetpackPlayer")
onready var items = [star, ring, coin]
onready var min_level = Globals.current_level_height
onready var max_level = Globals.current_level_height + Constants.LEVEL_HEIGHT
var rng = RandomNumberGenerator.new()

func _process(_delta):
	if (player.get_position().y < min_level and player.get_position().y > max_level):
		min_level = max_level
		max_level += Constants.LEVEL_HEIGHT
		
		if ($SpawnTimer.wait_time > 0.5 and $SpawnTimer.wait_time < 2.0):
			$SpawnTimer.wait_time = $SpawnTimer.wait_time - 0.20

func _on_SpawnTimer_timeout():
	rng.randomize()
	var getItem = rng.randi() % 3
	var item = items[getItem].instance()
	var jetpackPosition = player.get_position()
	var yLoc = rng.randf_range(jetpackPosition.y + 576, jetpackPosition.y - 288)
	var xLoc = rng.randf_range(jetpackPosition.x + 1024, jetpackPosition.x + 1536)
	item.set_position(Vector2(xLoc, yLoc))
	parent.add_child(item)
