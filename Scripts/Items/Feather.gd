extends Node2D

var speed = 250
var sprite = null
var feather_types = ["green_feather.png", "grey_feather.png",
	"pink_feather.png", "purple_feather.png", "red_feather.png"]
var velocity : Vector2 = Vector2()
onready var player = get_tree().get_root().get_node("Game/JetpackPlayer")
var index_value = 0

func _ready():
	$AnimationPlayer.play("default")
	
func _enter_tree():
	var index = randi() % 5
	index_value = index + 1
	$Sprite.texture = load("res://Sprites/Items/" + feather_types[index])

func _process(delta):
	move_local_x(-delta * speed)
	
	if (position.x < player.get_position().x - 1024 and is_instance_valid(self)):
		queue_free()

func _on_Area2D_body_entered(_body):
	$AudioStreamPlayer2D.play()
	_body.velocity.y = Constants.JUMP_FORCE * (index_value * 0.50)
	_body.move_and_slide(_body.velocity)
	hide()
