extends Node2D
var map_node
var build_mode= false
var build_valid = false 
var build_location
var build_type 

func _ready():
	map_node = get_node("Game")
	for i in get_tree().get_nodes_in_group("buildbutton"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
		
func _process(delta):
	if build_mode:
		update_tower_preview()

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()
	
func initiate_build_mode(tower_type):
	build_type = tower_type #+ "T1"
	build_mode = true 
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position = get_node("TowerExclusion").map_to_local(current_tile)
	print((get_node("TowerExclusion").get_cell_source_id(current_tile)))
	
	if get_node("TowerExclusion").get_cell_source_id(current_tile) == -1:
		get_node("UI").update_tower_preview(tile_position, "ad54ff3c")
		build_valid = true 
		build_location = tile_position
	
	else:
		get_node("UI").update_tower_preview(tile_position, "adff4545")
		build_valid = false
		

func cancel_build_mode():
	build_mode = false 
	build_valid = false 
	get_node("UI/TowerPreview").queue_free()
	
func verify_and_build():
	if build_valid:
		var new_tower = load("res://Scenes/" + build_type + ".tscn").instantiate()
		new_tower.position = build_location
		get_node("BoxOfTurrets").add_child(new_tower, true)
