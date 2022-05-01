class_name UI
extends Control

signal hover_finished
signal hovered_slot_selected

var _active_side: int = Side.LEFT

onready var selec_indic: TextureRect = $SelectionIndicator
onready var left_stats_panel   = $SidePanes/LeftPane/VBox/StatsPanel
onready var right_stats_panel  = $SidePanes/RightPane/VBox/StatsPanel
onready var left_scores_panel  = $SidePanes/LeftPane/VBox/AbilityScoresPanel
onready var right_scores_panel = $SidePanes/RightPane/VBox/AbilityScoresPanel


func _ready() -> void:
	selec_indic.connect("move_finished", self, "_on_selec_indic_move_finished")


# CH DISPLAY
func update_ch_display(ch_dict: Dictionary) -> void:
	update_stats(ch_dict.stats)
	update_ability_scores(ch_dict.scores)


func update_stats(stats: Dictionary) -> void:
	left_stats_panel.update_stat_display(stats)


func update_ability_scores(scores: Array) -> void:
	#TODO address active side
	left_scores_panel.update_score_display(scores)


# CHARACTER SELECTION
func select_hovered_slot() -> void:
	if selec_indic.ready_to_move:
		animate_selection()
		emit_signal("hovered_slot_selected")
	else:
		yield(selec_indic, "move_finished")
		animate_selection()
		emit_signal("hovered_slot_selected")


func animate_selection() -> void:
	#TODO
	pass


func move_hover_to(target_pos: Vector2) -> void:
	selec_indic.move_to(target_pos)


func reset_indic_to(pos: Vector2) -> void:
	selec_indic.warp_to(pos)


func _on_selec_indic_move_finished() -> void:
	emit_signal("hover_finished")


func is_ready_to_hover() -> bool:
	return selec_indic.ready_to_move
