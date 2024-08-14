extends Node

var sfx_group: ShinobuGroup

# Called when the node enters the scene tree for the first time.
func _ready():
	Shinobu.initialize()
	sfx_group = Shinobu.create_group("sfx_group", null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
