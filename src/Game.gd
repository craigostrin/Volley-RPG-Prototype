extends Node2D

#CENTRAL TODO LIST
## Mechanics
### Players need HP and Stamina
## UI Pane:
### Make it switch between left and right, and reset to 0th ch slot
### Make the list a grid or do away with the list entirely
### Add player panel with name, HP, and Stamina bars instead of ch select list

const WORLD_LEFT_POS  = Vector2(  0, 0)
const WORLD_RIGHT_POS = Vector2(200, 0)

var active_side: int  = Side.LEFT setget _set_active_side
var active_team: Team
#TODO ch stat manager
## Game should just manage turns, active team, UI hookups + selection, etc
#TODO combat manager
var team_l_ch_dicts := []
var team_r_ch_dicts := []

onready var test_timer: Timer = $PlaceholderTimer
onready var test_char: Character = $World/Teams/Team/Character1

onready var combat_manager: CombatManager = $CombatManager
onready var world: Node2D = $World
onready var ui_pane_l: Control = $World/UIPanes/UIPaneLeft
onready var ui_pane_r: Control = $World/UIPanes/UIPaneRight
onready var ch_select_panel: PanelContainer = \
	$World/UIPanes/UIPaneLeft/VBox/ChSelectPanelContainer
onready var team_l: Team = $World/Teams/Team
onready var team_r: Team = $World/Teams/Team2


func _ready() -> void:
	ch_select_panel.connect("selector_moved", self, "_on_ui_selector_moved")
	ch_select_panel.connect("ch_selected", self, "_on_ch_selected")
	combat_manager.connect(\
		 "attack_action_completed", self, "_on_attack_action_completed")
	combat_manager.connect(\
		"defense_action_completed", self, "_on_defense_action_completed")
	
	init_match()
	ui_pane_l.is_active_pane = true


func _unhandled_input(event: InputEvent) -> void:
	#DEBUG
	if event.is_action_pressed("debug_quit"):
		get_tree().quit()
	#DEBUG BUTTON
	if event.is_action_pressed("ui_focus_next"):
		if active_side == Side.LEFT:
			active_side = Side.RIGHT
			world.move_screen_to(Side.LEFT)
		else:
			active_side = Side.LEFT
			world.move_screen_to(Side.RIGHT)


# MATCH MANAGEMENT
func init_match() -> void:
	self.active_side = Side.LEFT
	active_team.hover(0)


func start_next_turn() -> void:
	# active team changes in End_Turn() unless there's a reason to do it here
	
	#1 move screen
	#2 swap active teams
	#3 swap active panes
	pass


func start_attack_phase() -> void:
	#init active_ch_select_panel.activate_selection
	pass


func end_turn() -> void:
	#clean up turn
	self.active_side = Side.R if active_side == Side.L else Side.L
	#world.move_screen_to(Enum.Team[active_side])


#func get_team_stats() -> void:
#	team_l_ch_dicts = team_l.get_ch_stats()
#	team_r_ch_dicts = team_r.get_ch_stats()
#
#func populate_player_ch_names() -> void:
#	var ch_names: PoolStringArray = []
#	for dict in team_l_ch_dicts:
#		ch_names.append(dict["Name"])
#
#	ch_select_panel.populate_team_names(ch_names)

func _set_active_side(val: int) -> void:
	if not val in Side.values():
		printerr("Error setting sides in Game.gd.")
		return
	
	active_side = val
	active_team = team_l if active_side == Side.LEFT else team_r


# UI SIGNALS
func _on_ui_selector_moved(ch_slot_hovered: int) -> void:
	active_team.hover(ch_slot_hovered)

func _on_ch_selected(ch_slot: int) -> void:
	active_team.select(ch_slot)


# COMBAT SIGNALS
func _on_defense_action_selected() -> void:
	print("defense action selected, play action")
	combat_manager.init_defense_action(-1)


func _on_defense_action_completed() -> void:
	#animation plays
	yield(test_timer.start(), "timeout")
	print("defense completed, start attack phase")
	start_attack_phase()


func _on_attack_action_selected() -> void:
	print("attack action selected, play action")
	combat_manager.init_attack_action(-1)

func _on_attack_action_completed() -> void:
	#animation plays
	yield(test_timer.start(), "timeout")
	print("attack completed, start next player's turn")
	end_turn()
