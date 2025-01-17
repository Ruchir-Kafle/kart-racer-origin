extends StaticBody3D

var front_camera_parent
var front_camera
var car

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is VehicleBody3D:
		
		car = body
		
		front_camera_parent = car.find_child("Cameras")
		front_camera = front_camera_parent.find_child("FrontCamera")
		
		car.SPEED_BOOST = true
		
		if car.ZOOM_DURATION == 0:
			var fov_out_tween = get_tree().create_tween()
			var center_of_mass_rotation_tween = get_tree().create_tween()
			fov_out_tween.tween_property(front_camera, "fov", 115, 0.3)
			center_of_mass_rotation_tween.tween_property(front_camera_parent, "rotation_degrees", Vector3(10, 0, 0), 0.3)
		
		car.ZOOM_DURATION += 2.5
		
		$CameraTimer.start()

func _on_camera_timer_timeout() -> void:
	car.ZOOM_DURATION -= 2.5

	if car.ZOOM_DURATION == 0:
		var fov_in_tween = get_tree().create_tween()
		var center_of_mass_reversion_tween = get_tree().create_tween()
		fov_in_tween.tween_property(front_camera, "fov", 75, 0.3)
		center_of_mass_reversion_tween.tween_property(front_camera_parent, "rotation_degrees", Vector3(0, 0, 0), 0.3)
	
	car.SPEED_BOOST = false
	$CameraTimer.stop()
