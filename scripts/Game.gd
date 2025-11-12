extends Node2D

var levels = []
var current_level_index := 0
var player := null

func _ready() -> void:
    # Load levels from JSON data
    var f = File.new()
    if f.file_exists("res://data/levels.json"):
        f.open("res://data/levels.json", File.READ)
        var txt = f.get_as_text()
        f.close()
        levels = JSON.parse(txt).result
    else:
        levels = []

    _load_level(current_level_index)

func _load_level(index: int) -> void:
    # clear previous children
    for c in get_children():
        c.queue_free()

    if index < 0 or index >= levels.size():
        print("No such level: ", index)
        return

    var info = levels[index]

    # spawn platforms
    for p in info.platforms:
        var plat = StaticBody2D.new()
        var col = CollisionShape2D.new()
        var rect = RectangleShape2D.new()
        rect.extents = Vector2(p.size.x / 2.0, p.size.y / 2.0)
        col.shape = rect
        plat.position = Vector2(p.pos.x + p.size.x/2.0, p.pos.y + p.size.y/2.0)
        plat.add_child(col)
        add_child(plat)

    # spawn player
    player = load('res://scenes/Player.tscn').instantiate()
    player.name = "Player"
    player.position = Vector2(info.playerStart.x, info.playerStart.y)
    var ps = preload("res://scripts/Player.gd")
    player.set_script(ps)
    add_child(player)

    # spawn enemies
    for e in info.enemies:
        var enemy = load('res://scenes/Enemy.tscn').instantiate()
        enemy.name = "Enemy"
        enemy.position = Vector2(e.pos.x, e.pos.y)
        var es = preload("res://scripts/Enemy.gd")
        enemy.set_script(es)
        # configure patrol bounds if provided
        if e.has("patrolMin"): enemy.set("patrol_min_x", e.get("patrolMin"))
        if e.has("patrolMax"): enemy.set("patrol_max_x", e.get("patrolMax"))
        add_child(enemy)

    # spawn goal as Area2D
    var goal = Area2D.new()
    goal.name = "Goal"
    goal.position = Vector2(info.goalPos.x, info.goalPos.y)
    var gcol = CollisionShape2D.new()
    var grect = RectangleShape2D.new()
    grect.extents = Vector2(16, 32)
    gcol.shape = grect
    goal.add_child(gcol)
    add_child(goal)
    goal.connect("body_entered", Callable(self, "_on_goal_entered"))

func _on_goal_entered(body) -> void:
    if body.name == "Player":
        print("Level complete, advancing...")
        current_level_index += 1
        if current_level_index >= levels.size():
            print("All levels complete!")
        else:
            _load_level(current_level_index)


func _create_parallax() -> void:
    var par = ParallaxBackground.new()
    par.limit_sm = Vector2(0,0)
    add_child(par)
    var layer0 = ParallaxLayer.new()
    var sprite0 = Sprite2D.new()
    sprite0.texture = load("res://assets/bg_layer0.png")
    layer0.motion_scale = Vector2(0.3,0.0)
    layer0.add_child(sprite0)
    par.add_child(layer0)
    var layer1 = ParallaxLayer.new()
    var sprite1 = Sprite2D.new()
    sprite1.texture = load("res://assets/bg_layer1.png")
    layer1.motion_scale = Vector2(0.6,0.0)
    layer1.add_child(sprite1)
    par.add_child(layer1)
    var layer2 = ParallaxLayer.new()
    var sprite2 = Sprite2D.new()
    sprite2.texture = load("res://assets/bg_layer2.png")
    layer2.motion_scale = Vector2(1.0,0.0)
    layer2.add_child(sprite2)
    par.add_child(layer2)

