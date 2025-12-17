extends Control

@onready var players_count: Label = $PlayersCount
@onready var start_label: Label = $StartLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_lobby_visible(visible: bool) -> void:
	self.visible = visible

#HERE IS THE COUNT FOR PLAYERS
func update_player_count(count: int) -> void:
	players_count.text = "Players: %d" % count

func set_start_label_visible(visible: bool) -> void:
	start_label.visible = visible
