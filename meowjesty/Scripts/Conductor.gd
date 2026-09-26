extends Node2D

var note_map: Array[float]= [1]
var song_pos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hello")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(str(Time.get_ticks_msec()))
	if Input.is_action_just_pressed("ui_accept"):
		print("space pressed")
		hit_acc(note_map)
		
	
	pass

func hit_acc(note_map1: Array[float]) -> void:
	var current_time = Time.get_ticks_msec() # replace with current song posistion
	var i = 0
	
	while (note_map1[i] < current_time) and (i < note_map1.size()-1): # find closest note timing
		i += 1
	if i != 0:
		i-=1
	
	var timing_error = abs(current_time + note_map1[i]) # the error (in ms) of timing
	
	if timing_error < 100:
		print("great!")
	elif timing_error < 200:
		print("good!")
	elif timing_error < 300:
		print("ok!")
	else:
		print("miss!")
	print(str(timing_error) + "ms off")
	
	
	pass
