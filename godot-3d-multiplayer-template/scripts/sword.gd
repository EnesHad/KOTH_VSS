extends Node3D

var can_attack = true

func _ready() -> void:
	hide()
	$SwordModel/Area3D.monitoring = false
	$SwordModel/Area3D.monitorable = false

func swing_sword():
	if can_attack == false: return
	can_attack = false
	$Cooldown.start()
	play_animation()

func play_animation():
	show()
	$SwordModel/Area3D.monitoring = true
	$SwordModel/Area3D.monitorable = true
	
	$AnimationPlayer.play("swing")
	await $Cooldown.timeout
	$AnimationPlayer.stop()
	
	hide()
	$SwordModel/Area3D.monitoring = false
	$SwordModel/Area3D.monitorable = false

func _on_cooldown_timeout() -> void:
	can_attack = true


func _on_area_3d_body_entered(body: Node3D) -> void:
	
	if body == owner:
		return
	
	if body is PhysicsBody3D:
		var body_position = body.position
		var area_position = self.position
		
		var direction = (body_position - area_position).normalized()
		
		if body.has_method("rpc_take_damage"):
			body.rpc_take_damage.rpc_id(body.get_multiplayer_authority())
		if body.has_method("rpc_take_knockback"):
			body.rpc_take_knockback.rpc_id(body.get_multiplayer_authority(), direction)
