extends Control

var item_icon: Texture = null
var quantity: int = 0

var is_selected := false

func update_slot(icon: Texture, qty: int, rarity_visible: bool=false):
	$ItemIcon.texture = icon
	$QuantityLabel.text = str(qty)
	$RarityBorder.visible = rarity_visible

func set_selected(selected: bool):
	is_selected = selected
	$RarityBorder.visible = selected
