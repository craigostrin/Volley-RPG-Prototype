extends PanelContainer

#TODO
## Fix character select - should be based on active team, and reset when screen moves
## Add function to show/hide ScorePanel based on active screen side
## UIPanes should be a bit smaller
## Font overall could be a bit smaller
## ScorePanel
###		2 modes: translucent (when point just scored) and mostly transparent
###			(most of the time)
###		Should fade-in from top when switching sides
#FUTURE
## Canvas Modulate Node can help with transition animations


var is_active_pane := false

onready var ch_select_panel = $VBox/ChSelectPanelContainer


func _unhandled_input(event: InputEvent) -> void:
	if is_active_pane:
		if event.is_action_pressed("ui_down"):
			ch_select_panel.move_selector_down()
		elif event.is_action_pressed("ui_up"):
			ch_select_panel.move_selector_up()
		elif event.is_action_pressed("ui_accept"):
			ch_select_panel.select_ch()
