extends Node2D

#WORKING ON
## refactoring character slots in Team and Character

#CENTRAL TODO LIST
## Mechanics
### Players need HP and Stamina
## UI Pane:
### Make it switch between left and right, and reset to 0th ch slot
### Make the list a grid or do away with the list entirely

const WORLD_LEFT_POS  = Vector2(  0, 0)
const WORLD_RIGHT_POS = Vector2(200, 0)

var active_side: int  = Side.LEFT setget _set_active_side
var active_team: Team
#TODO ch stat manager
## Game should just manage turns, active team, UI hookups, etc
#TODO combat manager
var team_l_ch_dicts := []
var team_r_ch_dicts := []

onready var test_timer: Timer = $PlaceholderTimer
onready var test_char: Character = $World/Teams/Team/Character1

onready var combat_manager: CombatManager = $CombatManager
onready var world: Node2D = $World
onready var left_pane: Control = $World/UI/SidePanes/LeftPane
onready var right_pane: Control = $World/UI/SidePanes/RightPane
onready var ch_select_panel: PanelContainer = \
	$World/UI/SidePanes/LeftPane/VBox/ChSelectPanelContainer
onready var team_l: Team = $World/Teams/Team
onready var team_r: Team = $World/Teams/Team2


func _ready() -> void:
	combat_manager.connect(\
		 "attack_action_completed", self, "_on_attack_action_completed")
	combat_manager.connect(\
		"defense_action_completed", self, "_on_defense_action_completed")
	
	init_match()
	left_pane.is_active_pane = true


func _unhandled_input(event: InputEvent) -> void:
	#DEBUG
	if event.is_action_pressed("debug_quit"):
		get_tree().quit()
	#DEBUG BUTTON
	if event.is_action_pressed("ui_focus_next"):
		if active_side == Side.LEFT:
			self.active_side = Side.RIGHT
		else:
			self.active_side = Side.LEFT


# MATCH MANAGEMENT
func init_match() -> void:
	active_side = Side.LEFT


func start_next_turn() -> void:
	# active team changes in End_Turn() unless reason to do here
	
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


func _set_active_side(val: int) -> void:
	if not val in Side.values():
		printerr("Error setting sides in Game.gd.")
		return
	
	world.switch_side_to(active_side)
	
	active_side = val
	active_team = team_l if active_side == Side.LEFT else team_r
	
	


# UI SIGNALS
#func _on_ui_selector_moved(ch_slot_hovered: Vector2) -> void:
#	active_team.hover(ch_slot_hovered)

func _on_ch_selected(ch_slot: Vector3) -> void:
	#active_team.select(ch_slot)
	pass


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
	#end_turn()
