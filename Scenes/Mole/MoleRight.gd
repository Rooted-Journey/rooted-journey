extends KinematicBody2D

const MOLE_SOUNDS = [
	"res://Assets/Audio/Tiere/mole_chew1.mp3",
	"res://Assets/Audio/Tiere/mole_chew2.mp3",
	"res://Assets/Audio/Tiere/mole_chew3.mp3",
]

func _ready():
	$AudioStreamPlayer2D.stream = load(MOLE_SOUNDS[randi()%3])

func _physics_process(_delta):
	if Globals.invincibility_remaining <= 0:
		collision_mask = 1
		collision_layer = 1
	else:
		collision_mask = 2
		collision_layer = 2
	self.position.x += 5
