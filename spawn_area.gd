extends Node3D

@onready var spawn_yellow: Node3D = $"."
@onready var spawn_blue: Node3D = $"../Spawn_BLUE"
@onready var spawn_green: Node3D = $"../Spawn_YELLOW"
@onready var spawn_red: Node3D = $"../Spawn_GREEN"

func get_spawn_point_for_skin(skin: String) -> Vector3:
	match skin:
		"yellow":
			return spawn_yellow.global_position
		"blue":
			return spawn_blue.global_position
		"green":
			return spawn_green.global_position
		"red":
			return spawn_red.global_position
		_:
			return Vector3.ZERO
