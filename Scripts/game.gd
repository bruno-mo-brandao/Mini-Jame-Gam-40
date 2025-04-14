extends Node2D
var map_node
var build_mode= false
var build_valid = false 
var build_location
var build_type 
var build_tile
var score = 1
var moneyS = 0
var time = 0
var timetoad = 8
var adsinround = 12
var hp = 5000
@onready var hpLabel: Label = $UI/HUD/Build/hp
@onready var money: Label = $UI/HUD/Build/money
@onready var pointslabel: Label = $UI/HUD/Build/pointslabel
@onready var golabel: Label = $GameOverScreen/VBoxContainer/Label
@onready var game_over_screen: ColorRect = $GameOverScreen
var gameovervar = false

func _ready():
	Engine.time_scale = 1
	game_over_screen.hide()
	for i in get_tree().get_nodes_in_group("buildbutton"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
		
func _process(delta):
	if not gameovervar:
		score = score + 1
	if hp > 999:
		var milhares = floor(hp/1000)
		var centenas = floor((hp - (milhares * 1000))/100)
		hpLabel.text = "HP: " + str(milhares) + "."+ str(centenas) + "k"
	elif hp > 0:
		hpLabel.text = "HP: " + str(hp)
	else:
		gameover()
	pointslabel.text = "Points: " + str(score)
	if not gameovervar:
		moneyS = moneyS + 0.08
	var moneyX = round(moneyS*pow(10,1))/pow(10,1)
	money.text=str(moneyX) + "$"
	if build_mode:
		update_tower_preview()
	time = time + delta	
	if score % 150 == 0:
		spawn()
	if (round(time) == timetoad):
		if timetoad != 1:
			adsinround = adsinround -1
		time = 0
		newad()
		if adsinround == 0:
			adsinround = 10
			timetoad = timetoad -1
func gameover():
	gameovervar = true
	Engine.time_scale = 0
	game_over_screen.show()
	golabel.text = "Game Over!\n" + "You scored " + str(score)+ "points!"
	pass

func spawn():
	var pathnr = randi_range(1, 8)
	var enemynr = randi_range(1, 3)
	#print("Spawned: " + str(enemynr) + " Path: "+ str(pathnr))
	var enemy = load("res://Scenes/enemy" + str(enemynr) +".tscn").instantiate()
	enemy.add_to_group("Enemy")
	#var enemy = load("res://Scenes/enemy1.tscn").instantiate()
	get_node("Path"+str(pathnr)).add_child(enemy, true)
	#get_node("Path1").add_child(enemy, true)
	#await (get_tree().create_timer(i[1])).timeout

func newad():
	
	var new_ad = load("res://Scenes/ads.tscn").instantiate()
	var posX = randi_range(0, 1250)
	var posY = randi_range(100, 650)
	#print("AD" + str(posX) + " " + str(posY))
	new_ad.position = Vector2(posX, posY)
	get_node("ads").add_child(new_ad, true)

func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()
	
func initiate_build_mode(tower_type):
	if build_mode:
		cancel_build_mode()
	build_type = tower_type #+ "T1"
	build_mode = true 
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position = get_node("TowerExclusion").map_to_local(current_tile)
	#print((get_node("TowerExclusion").get_cell_source_id(current_tile)))
	
	if get_node("TowerExclusion").get_cell_source_id(current_tile) == -1:
		get_node("UI").update_tower_preview(tile_position, "ad54ff3c")
		build_valid = true 
		build_location = tile_position
		build_tile = current_tile
	
	else:
		get_node("UI").update_tower_preview(tile_position, "adff4545")
		build_valid = false
		

func cancel_build_mode():
	build_mode = false 
	build_valid = false 
	get_node("UI/TowerPreview").free()
	
func verify_and_build():
	var isThereMoney = verifyMoney(build_type)
	if build_valid and isThereMoney:
		var new_tower = load("res://Scenes/" + build_type + ".tscn").instantiate()
		new_tower.position = build_location
		get_node("BoxOfTurrets").add_child(new_tower, true)
		get_node("TowerExclusion").set_cell(build_tile, 2, Vector2(1, 0))

func verifyMoney(type):
	var typeA = str(type) + "1"
	var typeint = str(typeA)[6]
	if typeint == "1":
		if moneyS > 20:
			moneyS = moneyS-20
			return true
		else:
			return false
	elif typeint == "2":
		if moneyS > 50:
			moneyS = moneyS-50
			return true
		else:
			return false
	elif typeint == "3":
		if moneyS > 100:
			moneyS = moneyS-100
			return true
		else:
			return false
			
func damage():
	hp = hp - 1


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
