class_name Metronome
extends Node

@export var bpm: float = 120.0:
	get: 
		return bpm
	set(value): 
		playing = false
		bpm = value
@export var meter: int = 4:
	get:
		return meter
	set(value):
		playing = false
		meter = value
var start_time_msec := 0
var last_time_msec := 0
var last_beat := -1
var playing := false:
	get:
		return playing
	set(value):
		if value:
			start_time_msec = Shinobu.get_dsp_time()
			last_time_msec = start_time_msec
			last_beat = -1
		playing = value

signal beat

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing:
		var current_time_msec := Shinobu.get_dsp_time()
		if current_time_msec > last_time_msec:
			var current_beat = int(bpm * (current_time_msec - start_time_msec) / 60000)
			if current_beat > last_beat:
				var current_beat_time = int(start_time_msec + (60000 / bpm) * current_beat)
				emit_signal("beat", current_beat, current_beat_time)
				last_beat = current_beat
			last_time_msec = current_time_msec

#region Signal callbacks
func _on_set_playing(value: bool):
	playing = value
	
func _on_set_bpm(new_bpm: float):
	bpm = new_bpm
	
func _on_set_meter(new_meter: float):
	meter = int(new_meter)
#endregion
