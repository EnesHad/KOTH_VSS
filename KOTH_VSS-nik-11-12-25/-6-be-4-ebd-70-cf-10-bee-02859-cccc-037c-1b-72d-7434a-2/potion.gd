extends Node3D
class_name Potion

signal used(player_id)

func _input_event(camera, position, event, click_position):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("used", get_parent().get_multiplayer_authority())  # or player_id
		queue_free()
