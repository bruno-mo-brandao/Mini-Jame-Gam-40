extends Area2D

var SPEED = 200

func _physics_process(delta):
	var movement = Vector2.RIGHT.rotated(rotation) * SPEED * delta
	global_position += movement
	
func destroy():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy") or body.is_in_group("ad"):
		destroy()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
