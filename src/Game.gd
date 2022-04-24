extends Node2D


var active_team: Team
var team_l_ch_dicts := []
var team_r_ch_dicts := []

onready var test_char: Character = $Teams/Team/Character1
onready var ui: Control = $CanvasLayer/UI
onready var ch_select_panel: PanelContainer = \
	$CanvasLayer/UI/RightPanel/VBox/ChSelectPanelContainer
onready var team_l: Team = $Teams/Team
onready var team_r: Team = $Teams/Team2

func _ready() -> void:
	ch_select_panel.connect("selector_moved", self, "_on_ui_selector_moved")
	ch_select_panel.connect("ch_selected", self, "_on_ch_selected")
	get_team_stats()
	populate_player_ch_names()
	init_match()


func _unhandled_input(event: InputEvent) -> void:
	#DEBUG
	if event.is_action_pressed("debug_quit"):
		get_tree().quit()


func init_match() -> void:
	active_team = team_l
	active_team.hover(0)


func end_turn() -> void:
	active_team = team_r if active_team == team_l else team_l


func get_team_stats() -> void:
	team_l_ch_dicts = team_l.get_ch_stats()
	team_r_ch_dicts = team_r.get_ch_stats()


func populate_player_ch_names() -> void:
	var ch_names: PoolStringArray = []
	for dict in team_l_ch_dicts:
		ch_names.append(dict["Name"])
	
	ch_select_panel.populate_team_names(ch_names)


func _on_ui_selector_moved(ch_slot_hovered: int) -> void:
	active_team.hover(ch_slot_hovered)

func _on_ch_selected(ch_slot: int) -> void:
	active_team.select(ch_slot)
