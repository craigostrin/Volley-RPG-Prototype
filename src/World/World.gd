extends Node2D

signal ch_selected(character)

const LEFT_POS  = Vector2(  0, 0)
const RIGHT_POS = Vector2(200, 0)


onready var left_team        : Team       = $Teams/Team
onready var right_team       : Team       = $Teams/Team2
onready var ui               : UI    = $UI
onready var score_panel_left : ScorePanel = $UI/ScorePanels/ScorePanelLeft
onready var score_panel_right: ScorePanel = $UI/ScorePanels/ScorePanelRight
onready var t                : Tween      = $Tween


func _ready() -> void:
	ui.connect("ch_slot_selected", self, "_on_ch_slot_selected")
	
	var test_ch = get_ch_by_slot(Vector2.ZERO, Side.RIGHT)
	var indic_pos = test_ch.get_selection_indic_global_pos()
	$UI/SelectionIndicator.move_to(indic_pos)


func get_ch_by_slot(slot: Vector2, side: int) -> Character:
	var ch: Character
	var team = left_team if side == Side.LEFT else right_team
	
	ch = team.characters[slot]
	
	return ch


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


func _on_ch_slot_selected(slot: Vector2, side: int) -> void:
	var ch_selected := get_ch_by_slot(slot, side)
	emit_signal("ch_selected", ch_selected)
