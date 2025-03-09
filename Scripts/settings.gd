extends Node2D
@onready var volume_slider = $VBoxContainer/Volume
@onready var mute_checkbox = $VBoxContainer2/CheckBox

func _ready():
	var current_volume_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	volume_slider.value = db_to_linear(current_volume_db) * 100
	#mute_checkbox.pressed = AudioServer.is_bus_mute(AudioServer.get_bus_index("Master"))

func _on_settings_pressed():
	$AudioStreamPlayerClick.play()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_settings_mouse_entered():
	$AudioStreamPlayerHover.play()


func _on_volume_value_changed(value):
	var volume_db = linear_to_db(value / 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume_db)


func _on_check_box_toggled(button_pressed):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), button_pressed)

func linear_to_db(linear: float) -> float:
	return log(linear) * 20

func db_to_linear(db: float) -> float:
	return exp(db / 20)
