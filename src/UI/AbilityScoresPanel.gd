extends PanelContainer

#TODO only display relevant scores based on game state (eg, only see Block, Agility
#     psychology, etc, when you're picking a blocker)

var score_display_scene := preload("res://src/UI/AbilityScoreBlock.tscn") 

var labels := []
var scores := []

onready var vbox: VBoxContainer = $VBox


func update_score_display(ch_scores: Array) -> void:
	# Clean up existing score blocks since relevant scores will change based on
	# the situation
	for existing_block in vbox.get_children():
		existing_block.queue_free()
	
	# For each ability/score in character's score table:
	for score_block in ch_scores:
		# Pull out the data
		var label = score_block.label
		var score = str(score_block.score)
		
		# Instance a score_display and add the right text
		var score_display := score_display_scene.instance()
		score_display.get_node("ScoreLabel").text = label
		score_display.get_node("Score").text = score
		
		# Add the score display to the VBox
		vbox.add_child(score_display)
