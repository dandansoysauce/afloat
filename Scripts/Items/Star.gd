extends Node2D

var speed = 300
var velocity : Vector2 = Vector2()
var value = Globals.current_level * 300
onready var player = get_tree().get_root().get_node("Game/JetpackPlayer")

func _ready():
	$AnimationPlayer.play("default")

func _process(delta):
	move_local_x(-delta * speed)
	
	if (position.x < player.get_position().x - 1024 and is_instance_valid(self)):
		queue_free()

func _on_Area2D_body_entered(_body):
	$AudioStreamPlayer2D.play()
	Globals.score += value
	Globals.stars += 1
	hide()

