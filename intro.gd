extends Control

@onready var title_label: Label = $Title
@onready var music: AudioStreamPlayer2D = $IntroMusic

@export var next_scene: String = "res://main_menu.tscn"

func _ready() -> void:
	title_label.modulate.a = 0.0

	# Uruchom muzykę
	music.play()

	# Powolne pojawianie się napisu
	var tween = create_tween()
	
	tween.tween_interval(3.0)
	
	tween.tween_property(
		title_label,
		"modulate:a",
		1.0,
		3.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# Poczekaj na zakończenie muzyki lub 10 sekund
	await get_tree().create_timer(9.0).timeout

	# Przejście do MainMenu
	var fade = create_tween()
	fade.tween_property(
		title_label,
		"modulate:a",
		0.0,
		2.0
	)

	await fade.finished

	get_tree().change_scene_to_file(next_scene)
