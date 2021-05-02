extends KinematicBody2D

export(Vector2) var velocity
export var speed = 50
onready var SM = $StateMachine

func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func _ready():
	SM.set_state("Searching")

func _on_Area2D_body_entered(_body):
	pass # Replace with function body.
