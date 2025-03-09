extends AnimatedSprite2D
var dragging  = false
var of = Vector2(0,0)

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() #- of
