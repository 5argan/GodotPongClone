extends Node

func _ready():
	set_process(true)

func _process(delta):
	var player1 = get_node("PlayerBat")
	var player2 = get_node("EnemyBat")
	get_node("Player1Score").set_text(str(player1.score))
	get_node("Player2Score").set_text(str(player2.score))