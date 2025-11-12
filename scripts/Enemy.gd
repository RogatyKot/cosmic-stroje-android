extends CharacterBody2D
@export var speed: float = 80.0
var dir := 1
var patrol_min_x := 0
var patrol_max_x := 0
var health := 2

func _ready() -> void:
    var anim = AnimatedSprite2D.new()
    var sf = SpriteFrames.new()
        sf.add_frame("idle", load("res://assets/enemy_0.png"))
        sf.add_frame("idle", load("res://assets/enemy_1.png"))
    anim.frames = sf
    anim.animation = "idle"
    anim.play()
    add_child(anim)
    set_physics_process(true)

func _physics_process(delta: float) -> void:
    velocity.x = dir * speed
    velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
    velocity = move_and_slide(velocity, Vector2.UP)

    if position.x < patrol_min_x:
        dir = 1
    if position.x > patrol_max_x:
        dir = -1

func take_damage(amount: int) -> void:
    health -= amount
    if health <= 0:
        queue_free()
