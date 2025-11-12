
extends CharacterBody2D
@export var speed: float = 220.0
@export var jump_velocity: float = -520.0
@export var shoot_cooldown: float = 0.25

var velocity: Vector2 = Vector2.ZERO
var can_shoot_timer: float = 0.0
var health: int = 3

func _ready() -> void:
    set_physics_process(true)

func _physics_process(delta: float) -> void:
    var dir := 0
    if Input.is_action_pressed("move_left"):
        dir -= 1
    if Input.is_action_pressed("move_right"):
        dir += 1
    velocity.x = dir * speed
    if is_on_floor() and Input.is_action_just_pressed("jump"):
        velocity.y = jump_velocity
    velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
    velocity = move_and_slide(velocity, Vector2.UP)

    if can_shoot_timer > 0.0:
        can_shoot_timer -= delta
    if Input.is_action_just_pressed("shoot") and can_shoot_timer <= 0.0:
        _shoot_bullet()
        can_shoot_timer = shoot_cooldown

func _shoot_bullet() -> void:
    var bullet_scene = load("res://scenes/Bullet.tscn")
    var bullet = bullet_scene.instantiate()
    bullet.position = global_position + Vector2(24, -8)
    get_parent().add_child(bullet)
    # play SFX if exists
    var s = AudioStreamPlayer2D.new()
    s.stream = load("res://assets/audio/sfx_shoot.wav")
    add_child(s)
    s.play()

func take_damage(amount: int) -> void:
    health -= amount
    if health <= 0:
        queue_free()
