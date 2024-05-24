extends CharacterBody2D
class_name whale

signal die

@export var speed = 300.0

@onready var animated_sprite = $AnimatedSprite2D

var plankton_bottle = 0

var canDash = false
var isOpeningMouth = false

var lastTimeAccessed

func _ready():
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	lastTimeAccessed = Time.get_unix_time_from_system()
	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

	if(Input.is_action_pressed("mouth")):
		isOpeningMouth = true
	else:
		isOpeningMouth = false
		
	var lr = Input.get_axis("left","right")
	var tb = Input.get_axis("down","up")
	
	if lr > 0:
		animated_sprite.flip_h = false
	elif lr < 0:
		animated_sprite.flip_h = true
	
	if isOpeningMouth:
		animated_sprite.play("open_mouth")
	else:
		animated_sprite.play("forward")
	

var push_force = 80.0

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:		
			if(!isOpeningMouth && (Time.get_unix_time_from_system() - lastTimeAccessed) > 0.5):
				lastTimeAccessed = Time.get_unix_time_from_system()
				c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			elif(isOpeningMouth):
				var object = c.get_collider()
				object.GetEaten()
