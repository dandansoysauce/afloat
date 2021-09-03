extends Node

onready var player = get_tree().get_root().get_node("Game/JetpackPlayer")
var animation
var track
var previous_color
onready var min_level = Globals.current_level_height
onready var max_level = Globals.current_level_height + Constants.LEVEL_HEIGHT

func _ready():
	randomize()
	animation = $AnimationPlayer.get_animation("default")
	track = animation.find_track("ColorParallax/ColorLayer/GameColor:color")
	previous_color = animation.track_get_key_value(track, 0)

func _process(delta):
	if (player.get_position().y < min_level and player.get_position().y > max_level):
		min_level = max_level
		max_level += Constants.LEVEL_HEIGHT
		
		animation.track_set_key_value(track, 0, previous_color)
		var r = rand_range(0, 1.0)
		var g = rand_range(0, 1.0)
		var b = rand_range(0, 1.0)
		var new_color = Color(r, g, b, 1.0)
		previous_color = new_color
		animation.track_set_key_value(track, 1, new_color)
		$AnimationPlayer.play("default")
