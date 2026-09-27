extends Node2D

var note_map: Array[float] = []
var beat_length_ms: float = 0.0 
var bpm: float = 60.0 
var offset = 100
var combo = 0
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	set_song(1)
	
	for i in range(note_map.size()):
		print("Note at: " + str(note_map[i]) + " ms")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		hit_acc(note_map)
		
	

func hit_acc(note_map1: Array[float]) -> void:
	if note_map1.is_empty():
		print("No notes mapped!")
		return
		

	var current_time = audio_player.get_playback_position() * 1000.0

	var i = 0
	while (i < note_map1.size() - 1) and (note_map1[i] < current_time):
		i += 1
		
	# Check if the previous note was actually closer to current_time
	if i > 0 and abs(current_time - note_map1[i - 1]) < abs(current_time - note_map1[i]):
		i -= 1
	
	#Calculate timing error 
	var timing_error = abs(current_time- offset - note_map1[i])
	
	if timing_error < 50:
		print("great!")
		combo += 1
	elif timing_error < 100:
		print("good!")
		combo += 1
	elif timing_error < 150:
		print("ok!")
		combo += 1
	else:
		print("miss!")
		combo = 0
		
	print(str(timing_error) + "ms off")
	
	if timing_error < 300:
		note_map.remove_at(i)
	
func set_song(song: int) -> void:
	if song == 1:
		bpm = 180.0
		note_map = [0, 333, 666, 1333, 2666, 3000, 3333, 4000, 5333, 5666, 6000,
		6666, 8000, 8333, 8666, 9333, 10666, 11333, 12000, 12666, 13333, 14000,
		14666, 15333, 16000, 16666, 17333, 18000, 18666, 19333, 20000, 20666, 21333,
		22000, 22666, 23333, 24000, 24666, 25333, 26000,26666, 27333, 28000, 28666,
		29333, 30000, 30666, 31333, 32000, 32666, 33000, 33333, 33666, 34000, 34333,
		34666, 35333, 35666, 36000, 36333, 36666, 37000, 37333, 38333, 38666, 39000,
		39333, 39666, 40000, 40666, 41000, 41333, 41666, 42000, 42333, 42666, 43333,
		43666, 44000, 44333, 44666, 45000, 45333, 45666, 46333, 46666, 47000, 43333,
		47000, 47333, 47666, 48000, 49000, 49333, 49666, 50000, 50333, 50666, 51000,
		51333, 51666, 52000, 52333, 52666, 53000, 53333, 53500, 53666, 53833, 54000,
		54333, 54666, 54833, 55000, 55166, 55333, 55666, 56000, 56166, 56333, 56500,
		56666, 57000, 57333, 57666, 58000, 58333, 58666, 59000, 59333, 59666, 60000,
		60333, 60666, 61000, 61333, 61666, 62000, 62333, 62666, 63000, 63333, 63666,
		64000, 64333, 65000, 65333, 66666, 67000, 67666, 68000, 68333, 68666, 69000,
		69333, 69666, 70666, 72000, 72333, 73000, 73333, 74000, 74666, ]
	
	# How many milliseconds per beat
	beat_length_ms = 60000.0 / bpm
	
func play_song():
	audio_player.play()
	
