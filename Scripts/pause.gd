extends Control
@onready var main = $"../"

func _on_mainmenu_pressed():
	$AudioStreamPlayerClick.play()
	main.pauseMenu()


func _on_mainmenu_mouse_entered():
	$AudioStreamPlayerHover.play()


func _on_quit_mouse_entered():
	$AudioStreamPlayerHover.play()


func _on_quit_pressed():
	get_tree().quit()
