class_name UIPane
extends PanelContainer


var is_active_pane := false

onready var ability_scores_panel            = $VBox/AbilityScoresPanel
onready var action_select_panel             = $VBox/ActionSelectPanel
onready var action_desc_panel               = $VBox/ActionDescPanel
onready var action_desc_text: RichTextLabel = $VBox/ActionDescPanel/RichTextLabel
onready var stats_panel                     = $VBox/StatsPanel


func _ready() -> void:
	swap_to_ch_select_view()


func swap_to_action_view(avail_actions: Array) -> void:
	ability_scores_panel.hide()
	
	action_select_panel.populate_actions(avail_actions)
	
	action_select_panel.show()
	action_desc_panel.show()


func swap_to_ch_select_view() -> void:
	ability_scores_panel.show()
	action_select_panel.hide()
	action_desc_panel.hide()


# CH DISPLAY
func update_ch_display(ch_dict: Dictionary) -> void:
	update_stats(ch_dict.stats)
	update_ability_scores(ch_dict.scores)


func update_stats(stats: Dictionary) -> void:
	stats_panel.update_stat_display(stats)


func update_ability_scores(scores: Array) -> void:
	ability_scores_panel.update_score_display(scores)
