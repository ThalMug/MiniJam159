extends pickable_objects


# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_scale = 0 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func GetEaten():
	queue_free()
