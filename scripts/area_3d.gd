extends Area3D

@export var ONE_USE = true
#@export var COOLDOWN = 5

var hit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CollisionShape3D.disabled = hit


func _on_body_entered(body: Node3D) -> void:
		if body is VehicleBody3D or body is VehicleWheel3D:
			hit = true
			body.linear_velocity.z = 0
			body.linear_velocity.x = 0
			body.linear_velocity.y += 10
		
		if ONE_USE:
			queue_free()
		#else:
			#$Timer.new().start(COOLDOWN)
			#
#func _on_timer_timeout():
	#print(1)
	#hit = false
	
