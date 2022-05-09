extends PanelContainer

onready var name_label: Label     = $VBox/NameLabel
onready var stam_bar: ProgressBar = $VBox/Stamina/ProgressBar
onready var morale_bar: ProgressBar = $VBox/Morale/ProgressBar

func update_stat_display(d: Dictionary) -> void:
	name_label.text = d.name
	stam_bar.value = d.stamina
	morale_bar.value = d.morale
