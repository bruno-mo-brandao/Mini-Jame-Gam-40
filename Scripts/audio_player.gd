extends AudioStreamPlayer

const menu_music = preload("res://music/MountainTavern by TabletopAudio.mp3")

func playMusic(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func playMenuMusic():
	playMusic(menu_music)
