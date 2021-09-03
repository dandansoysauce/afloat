extends Node2D

var speed = 300
var velocity : Vector2 = Vector2()
onready var player = get_tree().get_root().get_node("Game/JetpackPlayer")

func _ready():
	$AnimationPlayer.play("default")

func _process(delta):
	move_local_x(-delta * speed)
	
	if (position.x < player.get_position().x - 1024 and is_instance_valid(self)):
		queue_free()

func _on_Area2D_body_entered(_body):
	$AudioStreamPlayer2D.play()
	_body.velocity.y = Constants.JUMP_FORCE * 2.75
	hide()
	
