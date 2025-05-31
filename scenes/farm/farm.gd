extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var grass: TileMapLayer = $Map/Grass
@onready var soil: TileMapLayer = $Map/Soil

var plant_scene: PackedScene = preload("res://scenes/plants/plant.tscn")

var terrain_set = 0
var terrain = 2

var tool: int = 1
var plants: Array[Vector2i]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var plant = plant_scene.instantiate()
	plant.global_position.x = 100
	plant.global_position.y = 100
	add_child(plant)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("clear"):
		remove_soil()
	elif Input.is_action_just_pressed("hit"):
		add_soil()
	elif Input.is_action_just_pressed("tool"):
		next_tool()
	
func get_cell_under_mouse():
	var mouse_position = grass.get_local_mouse_position()
	var cell_position = grass.local_to_map(mouse_position)
	var cell_source_id = grass.get_cell_source_id(cell_position)
	var local_cell_position = grass.map_to_local(cell_position)
	var distance = player.global_position.distance_to(local_cell_position)
	return [mouse_position, cell_position, cell_source_id, local_cell_position, distance]

func get_cell_under_mouse_soil():
	var mouse_position = soil.get_local_mouse_position()
	var cell_position = soil.local_to_map(mouse_position)
	var cell_source_id = soil.get_cell_source_id(cell_position)
	var local_cell_position = soil.map_to_local(cell_position)
	var distance = player.global_position.distance_to(local_cell_position)
	return [mouse_position, cell_position, cell_source_id, local_cell_position, distance]

func add_soil():
	var data = get_cell_under_mouse()
	if data[4] < 30 and data[2] != -1 and tool == 1:
		soil.set_cells_terrain_connect([data[1]], terrain_set, terrain) 

func remove_soil():
	var data = get_cell_under_mouse()
	if data[4] < 30:
		soil.set_cells_terrain_connect([data[1]], terrain_set, -1)

func add_plant():
	var data = get_cell_under_mouse_soil()
	if data[4] < 30 and data[2] != -1 and tool == 4 and not plants.find(data[1]):
		plants.append(data[1])
		
		

func next_tool():
	if tool < 4:
		tool+=1
	else:
		tool = 1
	
	print(tool)
