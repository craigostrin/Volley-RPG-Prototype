extends PanelContainer

#TODO
## Move score pane out of the UI pane and into the center screen
## When switching sides, the score pane should fadein from top and
## 		the UI panes should fadein/out from/to their respective sides
## UI panes should obviously be translucent.
#FUTURE
## Canvas Modulate Node can help with transition animations


onready var ch_select_panel = $VBox/ChSelectPanelContainer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		ch_select_panel.move_selector_down()
	elif event.is_action_pressed("ui_up"):
		ch_select_panel.move_selector_up()
	elif event.is_action_pressed("ui_accept"):
		ch_select_panel.select_ch()
