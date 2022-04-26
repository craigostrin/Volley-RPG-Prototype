extends Node2D

const LEFT_POS  = Vector2(  0, 0)
const RIGHT_POS = Vector2(200, 0)


onready var t                : Tween          = $Tween
onready var score_panel_left : ScorePanel = $ScorePanels/ScorePanelLeft
onready var score_panel_right: ScorePanel = $ScorePanels/ScorePanelRight


func move_screen_to(side: int) -> void:
	if not side in Side.values():
		return
	
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
	
	var sp_to_activate := score_panel_left  if side == Side.LEFT else score_panel_right
	var sp_to_deactive := score_panel_right if side == Side.LEFT else score_panel_left
	
	sp_to_activate.fade_in()
	sp_to_deactive.fade_out()
