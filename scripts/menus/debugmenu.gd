extends Control

func _ready() -> void:
	visible = false
	
	$Label.text = str((OS.get_static_memory_usage() / 1000000))
	var debug_change_currentlap = $SpinBox