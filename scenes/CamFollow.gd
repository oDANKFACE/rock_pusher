extends Camera2D

@export var tilemap: TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemap_rect = tilemap.get_used_rect()
	var tile_size = 16
	var world_size = tilemap_rect.size * tile_size
	limit_top = 0
	limit_left = 0
	limit_bottom = world_size.y
	limit_right = world_size.x
	limit_bottom = world_size.y
	limit_right = world_size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
