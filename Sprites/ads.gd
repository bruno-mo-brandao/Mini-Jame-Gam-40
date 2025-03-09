extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $Object
var nAds = 2


func _ready():
	var imagerand = randi_range(0, nAds-1)
	animated_sprite_2d.frame = imagerand
		
func _on_texture_button_pressed() -> void:
	queue_free()
