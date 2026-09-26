extends StaticBody2D

@export var is_ground : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var diff = position.x - $"../player".position.x
	if(is_ground && diff < -500):
		position.x += 2500
	pass
