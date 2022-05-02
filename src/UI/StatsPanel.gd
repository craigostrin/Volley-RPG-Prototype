extends PanelContainer

onready var name_label: Label     = $VBox/NameLabel
onready var hp_bar: ProgressBar   = $VBox/HP/ProgressBar
onready var stam_bar: ProgressBar = $VBox/Stamina/ProgressBar

func update_stat_display(d: Dictionary) -> void:
	name_label.text = d.name
	hp_bar.value = d.health
	stam_bar.value = d.stamina
