extends Node2D

@export var enemy_scene: PackedScene
@onready var spawn_location: PathFollow2D = $player/Camera2D/SpawnPath/SpawnLocation
@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	if enemy_scene == null:
		print("ERROR: enemy_scene is NOT assigned in the Inspector!")
	
	

func _on_spawn_timer_timeout() -> void:
	print("Timer ticked!")
	
	if enemy_scene == null:
		print("Cannot spawn: enemy_scene is null.")
		return

	var enemy = enemy_scene.instantiate()
	spawn_location.progress_ratio = 0.5
	enemy.global_position = spawn_location.global_position
	
	print("Spawning enemy at position: ", enemy.global_position)
	get_tree().current_scene.add_child(enemy)
	
