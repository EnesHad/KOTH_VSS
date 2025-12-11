extends Area3D

@export var points_per_second: float = 10.0  # Adjust as needed

var overlapping_players: Array = []

func _ready():
	# Connect signals for enter/exit
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D):
	if multiplayer.is_server() and body.is_in_group("players"):  # Assume players are in a "players" group
		if body not in overlapping_players:
			overlapping_players.append(body)

func _on_body_exited(body: Node3D):
	if multiplayer.is_server() and body.is_in_group("players"):
		if body in overlapping_players:
			overlapping_players.erase(body)

func _physics_process(delta: float):
	if multiplayer.is_server():
		for player in overlapping_players:
			# Add points (assuming player has a 'score' variable synced via MultiplayerSynchronizer)
			player.score += points_per_second * delta
			# Optionally, print for debugging: print("Player ", player.name, " gained points! New score: ", player.score)
