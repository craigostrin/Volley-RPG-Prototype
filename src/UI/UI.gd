extends Control

onready var ch_select_panel = $RightPanel/VBox/ChSelectPanelContainer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		ch_select_panel.move_selector_down()
	elif event.is_action_pressed("ui_up"):
		ch_select_panel.move_selector_up()
	elif event.is_action_pressed("ui_accept"):
		ch_select_panel.select_ch()

