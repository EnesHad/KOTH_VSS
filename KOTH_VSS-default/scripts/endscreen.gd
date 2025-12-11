extends Control

var health: int = 100

# ---------------------------------------------------------
#  Damage & Death Logic
# ---------------------------------------------------------
func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()


func die() -> void:
	health = 0

	# Optional: disable input / processing for the player
	set_process(false)
	set_physics_process(false)
	set_process_input(false)

	# Show death UI on the client
	get_tree().call_group("ui", "show_end_screen")

	# Notify the server/other peers
	rpc("rpc_player_died", multiplayer.get_unique_id())


# ---------------------------------------------------------
#  UI Logic
# ---------------------------------------------------------
func _ready() -> void:
	add_to_group("ui")
	visible = false


func show_end_screen() -> void:
	visible = true


func _on_respawn_button_pressed() -> void:
	visible = false

	# Ask server to respawn this player
	rpc_id(1, "request_respawn") # 1 = server peer ID


# ---------------------------------------------------------
#  Multiplayer Sync
# ---------------------------------------------------------
@rpc(any_peer)
func rpc_player_died(id: int) -> void:
	# Only show the end screen for the local player
	if multiplayer.get_unique_id() == id:
		show_end_screen()
