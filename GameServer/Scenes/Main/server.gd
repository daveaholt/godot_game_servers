extends Node

var network = ENetMultiplayerPeer.new()
var port = 9998
var max_players = 500

func _ready():
	Logger.GlobalLoggingLevel = Logger.logLevels.ERROR
	startServer()
	
func startServer():
	network.create_server(port, max_players)
	multiplayer.multiplayer_peer = network
	
	network.connect("peer_connected", _peerConnected)
	network.connect("peer_disconnected", _peerDisconnected)	
	
	Logger.LogInfo("Server started...")
	Logger.LogInfo("MultiplayerPeerId: " + str(multiplayer.get_unique_id()))
	
func _peerConnected(player_id):
	Logger.LogInfo("User " + str(player_id) + " connected")
	
func _peerDisconnected(player_id):
	Logger.LogInfo("User " + str(player_id) + " disconnected")
	
 
