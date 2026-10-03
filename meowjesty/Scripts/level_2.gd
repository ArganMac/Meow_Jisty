extends Node2D

@export var enemy_scene: PackedScene
@onready var spawn_location: PathFollow2D = $player/Camera2D/SpawnPath/SpawnLocation
@onready var spawn_timer: Timer = $SpawnTimer

var score = 0
var combo = 0
var notes := load_notes("res://note_maps/Fancy_Feast.txt")
var note_position = 0
var measure_beat = 1

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 180 * 2 # if we want to map eights, bpm can be doubled. (make sure to switch conductor? {needs change})

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm
var last_measure = 1

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 0
var spawn_4_beat = 0


func _ready() -> void:
	print("LEVEL 2 READY")
	randomize()
	$Conductor.beat.connect(_on_conductor_beat)
	$Conductor.measure.connect(_on_conductor_measure)
	$Conductor.play_with_beat_offset(7)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("hit_tilde"):
		get_tree().change_scene_to_file("res://winner.tscn")
	
func _on_spawn_timer_timeout() -> void:
	print("Timer ticked!")
	
	if enemy_scene == null:
		print("Cannot spawn: enemy_scene is null.")
		return


func _on_conductor_measure(position): # calls the values in the measure to be spawned
	print("measure signal: ", position)
	if position == 1:
		_spawn_notes(spawn_1_beat) 
	elif position == 2:
		_spawn_notes(spawn_2_beat) 
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)


func _spawn_notes(to_spawn):
	print("_spawn_notes called with: ", to_spawn)
	if to_spawn > 0:
		var enemy = enemy_scene.instantiate()
		spawn_location.progress_ratio = 0.1
		enemy.global_position = spawn_location.global_position
		print("enemy spawned at: ", enemy.global_position)
		get_tree().current_scene.add_child(enemy)
		
		
		
func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	print("increment_score called with by=", by, " → combo now: ", combo, " score now: ", score + by * combo)
	
	if by == 3:
		great += 1
	elif by == 2:
		good += 1
	elif by == 1:
		okay += 1
	else:
		missed += 1
	
	
	
func _on_conductor_beat(position: Variant) -> void: # reads notes out of notes array and tells when they spawn.
	print("beat signal: ", position)
	song_position_in_beats = position
	note_position = (position-1)
	if notes.size() > position-1:
		print("value read is: " + str(notes[position-1]))
		if notes[note_position] != 0: # if there is a note
			if  measure_beat == 4:
				spawn_4_beat = 1
				measure_beat = 0
			elif measure_beat == 3:
				spawn_3_beat = 1
			elif measure_beat == 2:
				spawn_2_beat = 1
			else:
				spawn_1_beat = 1
		else: # if there is no note
			if  measure_beat == 4:
				spawn_4_beat = 0
				measure_beat = 0
			elif measure_beat == 3:
				spawn_3_beat = 0
			elif measure_beat == 2:
				spawn_2_beat = 0
			else:
				spawn_1_beat = 0
	else:  # sets all spawns to 0 after map is over
		spawn_1_beat = 0
		spawn_2_beat = 0
		spawn_3_beat = 0
		spawn_4_beat = 0
	measure_beat += 1 







func load_notes(path: String) -> Array[int]: # takes the map data from a .txt file
	var result: Array[int] = []
	var text := FileAccess.get_file_as_string(path)
	for c in text:
		if c == "0":
			result.append(0)
		elif c == "1":
			result.append(1)
	print("Notes loaded!")
	for i in range(result.size()):
		print(str(result[i]))
	return result

func _on_end_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/winner.tscn")
