extends Control

@onready var players_count: Label = $PlayersCount
@onready var start_label: Label = $StartLabel

var player_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#HERE IS THE COUNT FOR PLAYERS
func update_player_count(count: int) -> void:
	players_count.text = "Players: %d" % count
