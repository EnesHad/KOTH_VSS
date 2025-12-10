extends Node3D

var can_attack = true

func _ready() -> void:
	hide()

func _physics_process(delta: float) -> void:
	if can_attack and Input.is_action_pressed("attack"):
		can_attack = false
		$Cooldown.start()
		play_animation()

func play_animation():
	show()
	$AnimationPlayer.play("swing")
	await $Cooldown.timeout
	$AnimationPlayer.stop()
	hide()

func _on_cooldown_timeout() -> void:
	can_attack = true


func _on_area_3d_body_entered(body: Node3D) -> void:
	# dodaj neko detekcijo da se ne sam ne zadenes
	if body.has_method("hit_by_sword"):
		body.hit_by_sword()
