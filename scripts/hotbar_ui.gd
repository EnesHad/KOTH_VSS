extends Control

@export var slot_scene: PackedScene
@export var slot_limit: int = 5

var slots: Array = []
var selected_slot := -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_slots()

func set_slot_limit(value):
	slot_limit = value
	generate_slots()
	
func generate_slots():
	# Clear old
	for c in $SlotsContainer.get_children():
		c.queue_free()
	slots.clear()
	
	# Generate new
	for i in range(slot_limit):
		var slot = slot_scene.instantiate()
		$SlotsContainer.add_child(slot)
		slots.append(slot)

func select_slot(index: int):
	if index < 0 or index >= slots.size():
		return
	
	# Remove highlight from old
	if selected_slot != -1:
		slots[selected_slot].set_selected(false)
	
	# Hightlight new
	slots[index].set_selected(true)
	selected_slot = index
