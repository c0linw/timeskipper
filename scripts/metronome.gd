class_name Metronome
extends Node

@export var bpm := 120:
	get: 
		return bpm
	set(value): 
		playing = false
		bpm = value
@export var meter := 4:
	get:
		return meter
	set(value):
		playing = false
		meter = value
var start_time_usec := 0
var last_time_usec := 0
var last_beat := -1
var playing := false:
	get:
		return playing
	set(value):
		if value:
			start_time_usec = Time.get_ticks_usec()
			last_time_usec = start_time_usec
			last_beat = -1
		playing = value

signal beat

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing:
		var current_time_usec := Time.get_ticks_usec()
		if current_time_usec > last_time_usec:
			var current_beat = bpm * (current_time_usec - start_time_usec) / 60000000
			if current_beat > last_beat:
				emit_signal("beat", beat)
				last_beat = current_beat
			last_time_usec = current_time_usec

#region Signal callbacks
func _on_set_playing(value: bool):
	playing = value
	
func _on_set_bpm(new_bpm: int):
	bpm = new_bpm
	
func _on_set_meter(new_meter: int):
	meter = new_meter
#endregion
