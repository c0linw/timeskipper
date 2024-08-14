extends Node

var click_sources = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var click1 = FileAccess.open("res://sounds/tri_1600hz_8ms.wav",FileAccess.READ)
	var buffer = click1.get_buffer(click1.get_length())
	click1.close()
	var click_source = Shinobu.register_sound_from_memory("tri_1600hz_8ms",buffer)
	click_sources["tri_1600hz_8ms"] = click_source

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_metronome_beat(beat: int, next_beat_time_msec: int):
	var sfx_player = click_sources["tri_1600hz_8ms"].instantiate(ShinobuGlobals.sfx_group)
	sfx_player.schedule_start_time(next_beat_time_msec)
	sfx_player.start()
