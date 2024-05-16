extends Node


@onready var score_label = $ScoreLabel

var score = 0


func _ready():
	score_label.text = str(score)


func add_point():
	score += 1
	score_label.text = str(score)
	print(score)


func host_game():
	MultiplayerManager.host_game()
	%MultiplayerHUD.hide()


func join_game():
	MultiplayerManager.join_game()
	%MultiplayerHUD.hide()
