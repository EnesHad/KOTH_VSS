extends Control

var item_icon: Texture = null
var quantity: int = 0

func update_slot(icon: Texture, qty: int, rarity_visible: bool=false):
	$ItemIcon.texture = icon
	$QuantityLabel.text = str(qty)
	$RarityBorder.visible = rarity_visible
