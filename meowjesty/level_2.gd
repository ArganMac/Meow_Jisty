extends Node2D

@export var enemy_scene: PackedScene
@onready var spawn_location: PathFollow2D = $player/Camera2D/SpawnPath/SpawnLocation
@onready var spawn_timer: Timer = $SpawnTimer

var i = 0

func _ready() -> void:
	if enemy_scene == null:
		print("ERROR: enemy_scene is NOT assigned in the Inspector!")

func _process(delta: float) -> void:
	if not Conductor.audio_player.playing:
		return
	if i >= Conductor.note_map.size():
		return
	var current_pos = Conductor.get_song_position() * 1000	
	if current_pos >= Conductor.note_map[i]-650:
		print(">>> SPAWNING note ", i, " (", Conductor.note_map[i], "ms) at song time ", current_pos)
		var enemy = enemy_scene.instantiate()
		spawn_location.progress_ratio = 0.5
		enemy.global_position = spawn_location.global_position
		get_tree().current_scene.add_child(enemy)
		i += 1
		
		
		
