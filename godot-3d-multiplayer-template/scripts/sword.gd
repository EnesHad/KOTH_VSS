extends Node3D

func play_animation():
	$AnimationPlayer.play("swing")

# koda za testiranje
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("jump"):
		play_animation()
