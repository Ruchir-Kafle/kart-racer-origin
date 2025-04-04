extends Node3D
class_name CustomAnimationComponent

@onready var thrown_objects = $"../.."
@onready var car = $"../../.."
@onready var forcefield = $"../../../Forcefield"
@onready var original_color = forcefield.mesh.material.albedo_color

@export var PARENT : RigidBody3D
@export var ANIMATION_TIMER: Timer
@export var DESTROY_TIMER: Timer
@export var CAMERA_TIMER: Timer

var tween_playing = false
var front_camera_parent
var front_camera

func _play() -> void:
	forcefield.mesh.material.albedo_color = Color(0, 0, 0, 0)
	forcefield.visible = true
	
	var forcefield_visibility_tween = get_tree().create_tween()
	forcefield_visibility_tween.tween_property(
		forcefield.mesh.material, "albedo_color", original_color, 0.1
	)
	var position_tween_up = create_tween()
	position_tween_up.set_trans(Tween.TRANS_QUAD)
	position_tween_up.set_ease(Tween.EASE_IN)
	position_tween_up.parallel().tween_property(
		PARENT, "position", Vector3(thrown_objects.position.x, thrown_objects.position.y + 1.25, thrown_objects.position.z), 0.1
	)

func _process(_delta: float) -> void:
	PARENT.position = Vector3(thrown_objects.position.x, thrown_objects.position.y + 1.25, thrown_objects.position.z)
	
	if not tween_playing:
		tween_playing = true
		
		car.get_node("CameraComponent")._camera_out()
		
		ANIMATION_TIMER.start()
		CAMERA_TIMER.start()

func _visibility():
	PARENT.visible = false
	
func _reset():
	forcefield.mesh.material.albedo_color = original_color
	forcefield.visible = false

func _on_animation_timer_timeout() -> void:
	var position_tween_down = create_tween()
	position_tween_down.set_trans(Tween.TRANS_QUAD)
	position_tween_down.set_ease(Tween.EASE_IN)
	position_tween_down.parallel().tween_property(
		PARENT, "position", Vector3(thrown_objects.position.x, thrown_objects.position.y, thrown_objects.position.z), 0.1
	)
	
	position_tween_down.tween_callback(_visibility)

func _on_camera_timer_timeout() -> void:
	car.get_node("CameraComponent")._camera_in()
	
	var forcefield_visibility_tween = get_tree().create_tween()
	forcefield_visibility_tween.parallel().tween_property(
		forcefield.mesh.material, "albedo_color", Color(0, 0, 0, 0), 0.3
	)

	forcefield_visibility_tween.tween_callback(_reset)
	
	DESTROY_TIMER.start()

func _on_destroy_timer_timeout() -> void:
	PARENT.queue_free()
