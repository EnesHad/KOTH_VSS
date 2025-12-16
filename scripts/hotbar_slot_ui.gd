extends Control

var item_icon: Texture = null

var is_selected := false

func update_slot(icon: Texture, rarity_visible: bool=false):
	$ItemIcon.texture = icon
	$RarityBorder.visible = rarity_visible

func set_selected(selected: bool):
	is_selected = selected
	$RarityBorder.visible = selected
