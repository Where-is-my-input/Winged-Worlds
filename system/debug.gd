extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://system/debu_2d.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
