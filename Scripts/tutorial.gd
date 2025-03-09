extends Node2D

var time = 0

func _physics_process(delta: float) -> void:
	time = time + delta	
	if (round(time) == 2):
		time = 0
		newad()

func newad():
	
	var new_ad = load("res://Scenes/ads.tscn").instantiate()
	var posX = randi_range(-500, 1250)
	var posY = randi_range(30, 650)
	print("AD" + str(posX) + " " + str(posY))
	new_ad.position = Vector2(posX, posY)
	get_node("ads").add_child(new_ad, true)

func _on_settings_pressed():
	$AudioStreamPlayerClick.play()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_settings_mouse_entered():
	$AudioStreamPlayerHover.play()
