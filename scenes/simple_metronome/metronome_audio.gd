extends Node

var click_sources = {
	"sin_800hz_4ms": null,
	"sin_1600hz_4ms": null,
	"tri_800hz_8ms": null,
	"tri_1600hz_8ms": null,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in click_sources.keys():
		var file = FileAccess.open("res://sounds/%s.wav" % key, FileAccess.READ)
		print("res://sounds/%s.wav" % key)
		var buffer = file.get_buffer(file.get_length())
		file.close()
		var click_source = Shinobu.register_sound_from_memory(key, buffer)
		click_sources[key] = click_source

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_metronome_beat(beat: int, next_beat_time_msec: int):
	var sfx_player = click_sources["sin_800hz_4ms"].instantiate(ShinobuGlobals.sfx_group)
	sfx_player.schedule_start_time(next_beat_time_msec)
	sfx_player.start()
