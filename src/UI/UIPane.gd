class_name UIPane
extends PanelContainer


onready var ability_scores_panel            = $VBox/AbilityScoresPanel
onready var action_select_panel             = $VBox/ActionSelectPanel
onready var action_desc_panel               = $VBox/ActionDescPanel
onready var action_desc_text: RichTextLabel = $VBox/ActionDescPanel/RichTextLabel
onready var stats_panel                     = $VBox/StatsPanel


func _ready() -> void:
	action_select_panel.connect("action_hovered", self, "_on_action_hovered")
	swap_to_ch_select_view()


# ACTION DISPLAY
func swap_to_action_view(avail_actions: Array) -> void:
	ability_scores_panel.hide()
	
	action_select_panel.populate_actions(avail_actions)
	action_select_panel.reset()
	
	action_select_panel.show()
	action_desc_panel.show()


func _on_action_hovered(description: String) -> void:
	update_description_text(description)


func update_description_text(desc) -> void:
	action_desc_text.text = desc


# CH DISPLAY
func swap_to_ch_select_view() -> void:
	ability_scores_panel.show()
	action_select_panel.hide()
	action_desc_panel.hide()


func update_ch_display(ch_dict: Dictionary) -> void:
	update_stats(ch_dict.stats)
	update_ability_scores(ch_dict.scores)


func update_stats(stats: Dictionary) -> void:
	stats_panel.update_stat_display(stats)


func update_ability_scores(scores: Array) -> void:
	ability_scores_panel.update_score_display(scores)
