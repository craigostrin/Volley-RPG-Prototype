# Top-level node for managing turns and combat
extends Node2D

var active_side: int  = Side.LEFT setget _set_active_side

#TODO combat manager
var team_l_ch_dicts := []
var team_r_ch_dicts := []

onready var test_timer: Timer = $PlaceholderTimer

onready var combat_manager: CombatManager = $CombatManager
onready var world: Node2D = $World


func _ready() -> void:
	combat_manager.connect(\
		 "attack_action_completed", self, "_on_attack_action_completed")
	combat_manager.connect(\
		"defense_action_completed", self, "_on_defense_action_completed")
	
	init_match()


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
	#active_team = team_l if active_side == Side.LEFT else team_r


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
