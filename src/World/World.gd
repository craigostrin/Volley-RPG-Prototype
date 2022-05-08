extends Node2D

signal ch_selected(character)

const LEFT_POS  = Vector2(  0, 0)
const RIGHT_POS = Vector2(200, 0)

var slots_per_team := 4
var rows_per_team := 2

var active_side := Side.LEFT

var can_select := false
var slot_to_hover := Vector3(0, 0, Side.LEFT)
var hovered_slot  := Vector3(0, 0, Side.LEFT)
var selected_ch: Character

onready var left_team        : Team       = $Teams/Team
onready var right_team       : Team       = $Teams/Team2
onready var ui               : UI    = $UI
onready var score_panel_left : ScorePanel = $UI/ScorePanels/ScorePanelLeft
onready var score_panel_right: ScorePanel = $UI/ScorePanels/ScorePanelRight
onready var t                : Tween      = $Tween


func _ready() -> void:
	ui.connect("hover_finished", self, "_on_hover_finished")
	ui.connect("hovered_slot_selected", self, "_on_hovered_slot_selected")
	
	init_teams()
	init_ui()
	can_select = true
	


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		var slot3 := Vector3.LEFT
		hover(slot3)
	if event.is_action_pressed("ui_right"):
		var slot3 := Vector3.RIGHT
		hover(slot3)
	if event.is_action_pressed("ui_down"):
		# UP is positive, which is down in 2D
		var slot3 := Vector3.UP
		hover(slot3)
	if event.is_action_pressed("ui_up"):
		# DOWN is negative, which is up in 2D
		var slot3 := Vector3.DOWN
		hover(slot3)
	
	if event.is_action_pressed("ui_accept"):
		select(hovered_slot)
	if event.is_action_pressed("ui_cancel"):
		ui.deselect()


# Set the team slots and trigger each team's init functions
func init_teams() -> void:
	var teams := [left_team, right_team]
	
	for team in teams:
		team.slots = slots_per_team
		team.get_characters()
		team.setup_team()


func init_ui() -> void:
	ui.active_side = Side.LEFT
	ui.reset_indic_to(get_ch_indic_pos(Vector3.BACK))
	var starting_ch_d := get_ch_by_slot3(Vector3.BACK).get_dict()
	ui.update_ch_display(starting_ch_d)


### CHARACTER SELECTION ###

func select(slot3: Vector3) -> void:
	if not can_select:
		printerr("Invalid selection attempt.")
		return
	
	ui.select_hovered_slot()


func _on_hovered_slot_selected() -> void:
	# Find the correct team based on slot3
	var side = hovered_slot.z
	var team: Team = _get_team_by_side(side)
	
	# Use slot2 to get the ch's up-to-date action list
	var slot2 = Vector2(hovered_slot.x, hovered_slot.y)
	var avail_actions: Array = team.select(slot2)
	ui.activate_action_view(avail_actions)


func hover(slot3_to_move: Vector3) -> void:
	if not ui.is_ready_to_hover():
		return
	
	slot_to_hover = hovered_slot + slot3_to_move
	if not is_in_grid(slot_to_hover):
		return
	
	var target_pos := get_ch_indic_pos(slot_to_hover)
	ui.move_hover_to(target_pos)


func _on_hover_finished() -> void:
	hovered_slot = slot_to_hover
	can_select = true
	var ch := get_ch_by_slot3(hovered_slot)
	var ch_dict := ch.get_dict()
	ui.update_ch_display(ch_dict)


### MOVE SCREEN ###

func switch_side_to(next_side: int) -> void:
	if not next_side in Side.values():
		return
	active_side = Side.LEFT if active_side == Side.RIGHT else Side.RIGHT
	hovered_slot = Vector3( 0, 0, active_side)
	
	ui.active_side = active_side
	var starting_ch := get_ch_by_slot3(Vector3(0,0,active_side))
	var starting_ch_d := starting_ch.get_dict()
	ui.update_ch_display(starting_ch_d)
	
	move_screen_to(next_side)
	
	var sp_to_activate := score_panel_left  if next_side == Side.LEFT else score_panel_right
	var sp_to_deactive := score_panel_right if next_side == Side.LEFT else score_panel_left
	
	sp_to_activate.fade_in()
	sp_to_deactive.fade_out()
	print("swap screen side")


func move_screen_to(side: int) -> void:
	var target_pos := Vector2.ZERO
	target_pos = LEFT_POS if side == Side.LEFT else RIGHT_POS
	
	t.interpolate_property(
		self,
		"position",
		position,
		target_pos,
		1.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)
	t.start()
	yield(t, "tween_all_completed")
	_on_screen_move_finished()


func _on_screen_move_finished() -> void:
	var target_pos := get_ch_indic_pos(hovered_slot)
	ui.reset_indic_to(target_pos)


### HELPERS ###

func get_ch_by_slot3(slot3: Vector3) -> Character:
	var ch: Character
	var side = slot3.z
	var team = _get_team_by_side(side)
	
	var slot2 := Vector2(slot3.x, slot3.y)
	ch = team.characters[slot2]
	
	return ch


func get_ch_indic_pos(slot3: Vector3) -> Vector2:
	var indic_pos := Vector2.ZERO
	var ch := get_ch_by_slot3(slot3)
	var side = slot3.z
	
	indic_pos = ch.position + ch.get_indic_pos()
	if side == Side.RIGHT:
		indic_pos += right_team.position
	
	return indic_pos


func _get_team_by_side(side: int) -> Team:
	var t: Team
	
	if side == Side.LEFT:
		t = left_team
	elif side == Side.RIGHT:
		t = right_team
	else:
		printerr("Invalid _get_team request. Try a valid side.")
	
	return t


func is_in_grid(slot3) -> bool:
	var is_in_grid := true
	
	var col: int = slot3.x
	var row: int = slot3.y
	var width: int = slots_per_team / rows_per_team
	
	var index := col + row * width
	
	if index < 0 or index > slots_per_team - 1:
		is_in_grid = false
	
	if col < 0 or row < 0 or col >= width:
		is_in_grid = false
	
	return is_in_grid
