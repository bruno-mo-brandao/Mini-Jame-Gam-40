extends Node2D
func _ready():
	pass
	#AudioPlayer.playMenuMusic()

func _on_two_players_pressed():
	$AudioStreamPlayerClick.play()
	get_tree().change_scene_to_file("res://scenes/adsmenu.tscn")

func _on_two_players_mouse_entered():
	$AudioStreamPlayerHover.play()


func _on_exit_pressed():
	$AudioStreamPlayerClick.play()
	get_tree().quit()
	
func _on_quit_mouse_entered():
	$AudioStreamPlayerHover.play()


func _on_settings_pressed():
	$AudioStreamPlayerClick.play()
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_settings_mouse_entered():
	$AudioStreamPlayerHover.play()


func _on_one_player_pressed():
	$AudioStreamPlayerClick.play()
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_one_player_mouse_entered():
	$AudioStreamPlayerHover.play()


func _on_how_to_play_mouse_entered():
	$AudioStreamPlayerHover.play()


func _on_how_to_play_pressed():
	$AudioStreamPlayerClick.play()
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")
