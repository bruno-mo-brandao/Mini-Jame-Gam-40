extends Node2D

@export var BULLET: PackedScene = null

var target: Node2D = null

@onready var turret_sprite: Sprite2D = $TurretSprite
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var timer: Timer = $RayCast2D/Timer


func _ready():
	await(get_tree().process_frame)
	target = find_target()

func _physics_process(delta):
	if target != null:
		var angle_to_target = global_position.direction_to(target.global_position).angle()
		ray_cast_2d.global_rotation = angle_to_target
		if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider().is_in_group("Enemy"):
			turret_sprite.rotation = angle_to_target
			if timer.is_stopped():
				shoot()

func shoot():
	ray_cast_2d.enabled = false
	if BULLET:
		var bullet = BULLET.instantiate()
		#get_parent().add_child(bullet)
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		bullet.global_rotation = ray_cast_2d.global_rotation
	
	timer.start()
	
func find_target():
	var new_target = null
	if get_tree().has_group("Enemy"):
		new_target = get_tree().get_nodes_in_group("Enemy")[0]
	return new_target


func _on_timer_timeout() -> void:
	ray_cast_2d.enabled = true
