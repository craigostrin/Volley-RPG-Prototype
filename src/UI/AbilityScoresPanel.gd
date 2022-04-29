extends PanelContainer


var labels := []
var scores := []

onready var vbox: VBoxContainer = $VBox

func _ready() -> void:
	init()


func update_score_display(a: Array) -> void:
	var i := 0
	for score_block in a:
		var label = score_block.label
		var score = str(score_block.score)
		labels[i].text = label
		scores[i].text = score
		i += 1


func init() -> void:
	for score_block in vbox.get_children():
		var label = score_block.get_node("StatLabel")
		labels.append(label)
		
		var score = score_block.get_node("Stat")
		scores.append(score)
