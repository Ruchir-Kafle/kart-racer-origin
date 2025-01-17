extends Control

var button_pressed

func _ready() -> void:
	$UITransition._fade_in_title_screen()
	#MusicPlayer.play_music_level()

func _on_single_player_pressed() -> void:
	button_pressed = "main_menu"
	$SFX.play()
	$UITransition._fade_out()

func _on_settings_pressed() -> void:
	button_pressed = "settings_menu"
	$SFX.play()
	$UITransition._fade_out()

func _on_quit_pressed() -> void:
	$SFX.play()
	get_tree().quit()

func _on_ui_transition_animation_end(is_fade_out) -> void:
	if is_fade_out:
		
		get_tree().change_scene_to_file("res://scenes/ui_scenes/menus/"+ button_pressed + ".tscn")
		
