extends Node2D
@export var velocity := Vector2(600, 0)

func _ready() -> void:
    var spr = Sprite2D.new()
    spr.texture = load("res://assets/bullet_0.png")
    add_child(spr)
    set_physics_process(true)

func _physics_process(delta: float) -> void:
    position += velocity * delta
    if position.x > 5000 or position.x < -1000:
        queue_free()
