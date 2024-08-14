extends Node

var click_sources := {
	"sin_800hz_4ms": null,
	"sin_1600hz_4ms": null,
	"tri_800hz_8ms": null,
	"tri_1600hz_8ms": null,
}
var sfx_players: Array[ShinobuSoundPlayer]
var click1 := "sin_800hz_4ms"
var click2 := "sin_1600hz_4ms"

var meter := 4

const OFFSET_MS := 50

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in click_sources.keys():
		var file = FileAccess.open("res://sounds/%s.wav" % key, FileAccess.READ)
		print("res://sounds/%s.wav" % key)
		var buffer = file.get_buffer(file.get_length())
		file.close()
		var click_source = Shinobu.register_sound_from_memory(key, buffer)
		click_sources[key] = click_source
	_on_set_meter(4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_metronome_beat(beat: int, beat_time_msec: int):
	var sfx_player = sfx_players[beat%meter]
	sfx_player.seek(0)
	sfx_player.schedule_start_time(beat_time_msec + OFFSET_MS)
	sfx_player.start()

func _on_set_meter(new_meter: int):
	for player in sfx_players:
		player.queue_free()
	sfx_players.clear()
	for i in range(0, new_meter):
		var click_key = click1 if i == 0 else click2
		var new_player = click_sources[click_key].instantiate(ShinobuGlobals.sfx_group)
		sfx_players.push_back(new_player)
