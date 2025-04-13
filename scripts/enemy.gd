extends PathFollow2D
var speed = [100,130,150]
var health = [2,4,6]
var enemy_speed = 25
var enemy_health = 0
var enemy_nr = 0

func _ready() -> void:
	var enemy_nr = (int(str(get_tree().root.get_child(0))[5]))
	var enemy_speed = speed[enemy_nr-1]
	var enemy_health = health[enemy_nr-1]
	
func _physics_process(delta: float) -> void:
	move(delta)
	checkRatio()
	
func move(delta):
	set_progress(get_progress() + enemy_speed * delta )
	
func checkRatio():
	if progress_ratio > 0.98:
		print ("B")
		var node = get_node("Game")
		node.damage()
