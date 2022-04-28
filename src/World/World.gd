extends Node2D

signal ch_selected(character)

const LEFT_POS  = Vector2(  0, 0)
const RIGHT_POS = Vector2(200, 0)

var slots_per_team := 4

var slot_to_hover := Vector3.ZERO
var hovered_slot := Vector3.ZERO
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
	ui.reset_indic_to(get_ch_indic_pos(Vector3(0, 0, 1)))


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		var slot3 := Vector3(-1, 0, 0 )
		hover(slot3)
	if event.is_action_pressed("ui_right"):
		var slot3 := Vector3( 1, 0, 0 )
		hover(slot3)
	if event.is_action_pressed("ui_down"):
		var slot3 := Vector3( 0, 1, 0 )
		hover(slot3)
	if event.is_action_pressed("ui_up"):
		var slot3 := Vector3( 0,-1, 0 )
		hover(slot3)


func init_teams() -> void:
	var teams := [left_team, right_team]
	
	for team in teams:
		team.slots = slots_per_team
		team.get_characters()
		team.setup_team()


func hover(slot3_to_move: Vector3) -> void:
	slot_to_hover = hovered_slot + slot3_to_move
	var target_pos := get_ch_indic_pos(slot_to_hover)
	
	ui.move_hover_to(target_pos)


func get_ch_by_slot3(slot3: Vector3) -> Character:
	var ch: Character
	var side = slot3.z
	var team = left_team if side == Side.LEFT else right_team
	
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


func move_screen_to(_Side: int) -> void:
	if not _Side in Side.values():
		return
	
	var target_pos := Vector2.ZERO
	target_pos = LEFT_POS if _Side == Side.LEFT else RIGHT_POS
	
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
	
	var sp_to_activate := score_panel_left  if _Side == Side.LEFT else score_panel_right
	var sp_to_deactive := score_panel_right if _Side == Side.LEFT else score_panel_left
	
	sp_to_activate.fade_in()
	sp_to_deactive.fade_out()


func _on_hover_finished() -> void:
	hovered_slot = slot_to_hover
	var ch_dict := {}
	#TODO
	ui.update_stats(ch_dict)


func _on_hovered_slot_selected() -> void:
	var ch_selected = get_ch_by_slot3(hovered_slot)
	emit_signal("ch_selected", ch_selected)
