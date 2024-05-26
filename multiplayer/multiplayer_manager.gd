extends Node


const SERVER_ADDRESS = "127.0.0.1"
const SERVER_PORT = 8080

var player_scene = load("res://multiplayer/multiplayer_player.tscn")


func host_game():
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	multiplayer.multiplayer_peer = server_peer

	multiplayer.peer_connected.connect(add_player_to_game)
	multiplayer.peer_disconnected.connect(remove_player_from_game)


func add_player_to_game(id: int):
	print("Player %s joined the game!" % id)
	var player = player_scene.instantiate()
	player.player_id = id
	player.name = str(id)


func remove_player_from_game(id: int):
	print("Player %s left the game!" % id)


func join_game():
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_ADDRESS, SERVER_PORT)
	multiplayer.multiplayer_peer = client_peer
