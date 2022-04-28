extends Node2D

signal ch_selected(character)

const LEFT_POS  = Vector2(  0, 0)
const RIGHT_POS = Vector2(200, 0)

var slot_to_hover := Vector2.ZERO
var hovered_slot := Vector2.ZERO

onready var left_team        : Team       = $Teams/Team
onready var right_team       : Team       = $Teams/Team2
onready var ui               : UI    = $UI
onready var score_panel_left : ScorePanel = $UI/ScorePanels/ScorePanelLeft
onready var score_panel_right: ScorePanel = $UI/ScorePanels/ScorePanelRight
onready var t                : Tween      = $Tween


func _ready() -> void:
	ui.connect("hover_finished", self, "_on_hover_finished")
	ui.connect("hovered_slot_selected", self, "_on_hovered_slot_selected")
	
	var indic_pos = get_ch_indic_pos(Vector2.ZERO, Side.RIGHT)
	ui.reset_indic_to(indic_pos)
	yield(get_tree().create_timer(2.0), "timeout")
	ui.move_hover_to(get_ch_indic_pos(Vector2.ONE, Side.RIGHT))
	yield(get_tree().create_timer(5.0), "timeout")
	ui.move_hover_to(get_ch_indic_pos(Vector2(0,1), Side.RIGHT))


#Could use a Vector3 instead if necessary
func get_ch_by_slot(slot: Vector2, side: int) -> Character:
	var ch: Character
	var team = left_team if side == Side.LEFT else right_team
	
	ch = team.characters[slot]
	
	return ch


func get_ch_indic_pos(slot: Vector2, side: int) -> Vector2:
	var indic_pos := Vector2.ZERO
	var ch := get_ch_by_slot(slot, side)
	
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
	var ch_dict := {}
	#TODO
	ui.update_stats(ch_dict)


func _on_hovered_slot_selected(slot: Vector2, side: int) -> void:
	var ch_selected := get_ch_by_slot(slot, side)
	emit_signal("ch_selected", ch_selected)
