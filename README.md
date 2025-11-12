Cosmic Strike - Godot 4 Full Port (Automated conversion prototype)
================================================================

What this archive contains:
- scripts/Player.gd   -> Player movement, jump, shoot (runtime instanced bullets)
- scripts/Enemy.gd    -> Simple enemy walker with patrol bounds
- scripts/Bullet.gd   -> Simple bullet entity that moves and can damage enemies
- scripts/Game.gd     -> Level loader and runtime spawner (reads data/levels.json)
- data/levels.json    -> Converted level definitions extracted from the original project
- assets/             -> Put art/sfx here and hook them into scenes or scripts
- README.md           -> This file

How to open in Godot 4:
1. Copy this folder into your Godot projects directory or open it from Godot (Project -> Open).
2. Create InputMap actions in Project Settings -> Input Map:
   - move_left  : A, Left
   - move_right : D, Right
   - jump       : W, Space, Up
   - shoot      : X, Z, Ctrl, or Mouse Button (as desired)
3. Create a new scene (Root Node2D). Attach the script 'res://scripts/Game.gd' to the root node and save as 'res://scenes/Main.tscn'.
4. Run the main scene. The loader will create platforms, the player, enemies, and a goal using the converted level data.
5. Replace placeholder nodes with Sprite2D/AnimatedSprite2D and AudioStreamPlayers as desired. Use assets/ for graphics.

Limitations & notes:
- This is an automated conversion prototype: complex behaviors, animations and exact physics tuning were not ported verbatim.
- Level geometry was translated from the original TypeScript level definitions where possible. Some fields may have been normalized.
- For polish, I'll convert art to Sprite2D nodes, add AnimatedSprite2D sheets, sound, and better enemy AI if you provide assets or confirm preferences.

Next steps I can do for you (pick one):
- 'polish_sprites' : I'll create simple Sprite2D nodes and placeholder art and wire visuals to nodes.
- 'ai_plus' : I'll enhance enemy AI (patrol, chase, shoot) and add health UI + pickups.
- 'export_tscn' : I'll generate actual .tscn scene files for Player/Enemy/Bullet and a saved Main.tscn (instead of runtime creation).


Enhanced: pixel-art sprites and simple animations added to assets/. Player/Enemy/Bullet now attach visual children at runtime.
