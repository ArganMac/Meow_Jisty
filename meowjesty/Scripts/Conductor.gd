extends Node2D

var note_map: Array[float] = []
var beat_length_ms: float = 0.0 
var bpm: float = 60.0 
var offset = 100

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
	elif timing_error < 100:
		print("good!")
	elif timing_error < 150:
		print("ok!")
	else:
		print("miss!")
	print(str(timing_error) + "ms off")

func set_song(song: int) -> void:
	if song == 1:
		bpm = 180.0
	
	# How many milliseconds per beat
	beat_length_ms = 60000.0 / bpm
	var total_length_ms = audio_player.stream.get_length() * 1000.0
	
	# Step through the song time beat-by-beat
	var current_beat_time = 0.0
	while current_beat_time < total_length_ms:
		note_map.append(current_beat_time)
		current_beat_time += beat_length_ms
	audio_player.play()
