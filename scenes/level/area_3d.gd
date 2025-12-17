extends Area3D
@export var score_label_path: NodePath
@onready var score_label: CanvasLayer = ($"../Scoreboard")


var players_in_zone := {
	Character.Team.BLUE: [],
	Character.Team.YELLOW: [],
	Character.Team.GREEN: [],
	Character.Team.RED: []
}

var team_scores := {
	Character.Team.BLUE: 0.0,
	Character.Team.YELLOW: 0.0,
	Character.Team.GREEN: 0.0,
	Character.Team.RED: 0.0
}

# Timer for debug printing
var debug_timer := 0.0
var debug_interval := 1.0

# King of the Hill state
var is_contested := false
var current_scoring_team := -1  # -1 = no team scoring

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if not multiplayer.is_server():
		return
	if body is Character:
		var team = body.team
		if not players_in_zone[team].has(body):
			players_in_zone[team].append(body)

func _on_body_exited(body):
	if not multiplayer.is_server():
		return
	if body is Character:
		var team = body.team
		players_in_zone[team].erase(body)

func _physics_process(delta):
	if not multiplayer.is_server():
		return

	var active_teams := []
	for team in players_in_zone.keys():
		if players_in_zone[team].size() > 0:
			active_teams.append(team)

	# Determine contested / scoring team
	if active_teams.size() == 1:
		var team = active_teams[0]
		if is_contested or current_scoring_team != team:
			# Contest resolved or new scoring team
			is_contested = false
			current_scoring_team = team
	else:
		if not is_contested:
			is_contested = true
			current_scoring_team = -1

	# Award points if not contested
	if not is_contested and current_scoring_team != -1:
		var player_count: int = players_in_zone[current_scoring_team].size()
		team_scores[current_scoring_team] += player_count * delta

	# Print debug once per second
	debug_timer += delta
	if debug_timer >= debug_interval:
		_print_scores()
		debug_timer = 0.0

func _print_scores():
	var text := ""
	if is_contested:
		text += "Status: CONTESTED!\n"
	else:
		text += "Scoring team: %s\n" % _get_team_name(current_scoring_team)

	for team in team_scores.keys():
		text += "Team %s: %d points\n" \
			% [_get_team_name(team), int(team_scores[team])]
	# Update Label text
	if is_multiplayer_authority():
		get_parent().rpc("sync_score", text)
	if score_label:
		score_label.updateText(text)
		

	# Also print to console for debugging
	print("\n------ SCOREBOARD ------\n" + text + "------------------------\n")


func _get_team_name(team: int) -> String:
	match team:
		Character.Team.BLUE: return "🟦BLUE"
		Character.Team.YELLOW: return "🟨YELLOW"
		Character.Team.GREEN: return "🟩GREEN"
		Character.Team.RED: return "🟥RED"
		_: return "UNKNOWN"
