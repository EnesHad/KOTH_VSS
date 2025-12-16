extends Node3D
class_name Potion

signal used

func use():
	emit_signal("used")
