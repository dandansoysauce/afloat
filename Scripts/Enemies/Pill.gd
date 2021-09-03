extends Node2D

var speed = 250
var sprite = null
var pill_types = ["blue_red_spots_pill.png",
	"green_blue_spots_pill.png", "white_black_spots_pill.png", "black_pill.png"]
var velocity : Vector2 = Vector2()
onready var player = get_tree().get_root().get_node("Game/JetpackPlayer")
var value = 0

func _ready():
	$AnimationPlayer.play("default")
	
func _enter_tree():
	value = (randi() % 3) + 1
	$Sprite.texture = load("res://Sprites/Enemies/" + pill_types[randi() % 4])

func _process(delta):
	move_local_x(-delta * speed)
	
	if (position.x < player.get_position().x - 1024 and is_instance_valid(self)):
		queue_free()

func _on_Area2D_body_entered(_body):
	$AudioStreamPlayer2D.play()
	if (Globals.airbags > 0):
		var airbags_left = Globals.airbags - value
		if (airbags_left < 0):
			Globals.airbags = 0
		else:
			Globals.airbags = airbags_left
	hide()
