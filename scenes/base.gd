extends Area2D
var node
func _ready() -> void:
	var node = get_node("Game")
func _physics_process(delta: float) -> void:
	
	var enemies = get_overlapping_bodies().size()
	print(enemies)
	if enemies > 0:
		get_parent().damage()
		
