extends Node


const SERVER_ADDRESS = "127.0.0.1"
const SERVER_PORT = 8080

var player_spawn_path: Node
var player_scene = load("res://multiplayer/multiplayer_player.tscn")


func host_game():
	player_spawn_path = get_tree().current_scene.get_node("Players")

	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	multiplayer.multiplayer_peer = server_peer

	multiplayer.peer_connected.connect(add_player_to_game)
	multiplayer.peer_disconnected.connect(remove_player_from_game)

	add_player_to_game(1)
	remove_singleplayer()


func add_player_to_game(id: int):
	print("Player %s joined the game!" % id)
	var player = player_scene.instantiate()
	player.player_id = id
	player.name = str(id)
	player_spawn_path.add_child(player)


func remove_player_from_game(id: int):
	print("Player %s left the game!" % id)
	if (player_spawn_path.has_node(str(id))):
		player_spawn_path.get_node(str(id)).queue_free()


func join_game():
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_ADDRESS, SERVER_PORT)
	multiplayer.multiplayer_peer = client_peer

	remove_singleplayer()


func remove_singleplayer():
	var player = get_tree().current_scene.get_node("Player")
	player.queue_free()
