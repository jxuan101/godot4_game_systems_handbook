# Reusable Architecture Guidelines

## Prefer composition over giant actor scripts

A player scene can compose movement, health, combat, inventory, interaction, and animation
components. Each component should own one responsibility and expose a small public API.

```text
Player (CharacterBody2D)
├── MovementController
├── HealthComponent
├── CombatComponent
├── InventoryComponent
├── InteractionSensor (Area2D)
└── AnimatedSprite2D
```

## Data-driven design

Use custom `Resource` classes for authored definitions such as items, weapons, enemies,
abilities, loot tables, and quests. Keep runtime mutable state separate from shared definitions.

## Communication

- Use direct references for tightly related child components.
- Use signals for one-to-many notifications.
- Use an Autoload event bus only for genuinely global events.
- Avoid hardcoded scene paths across unrelated systems.

## Physics

Move `CharacterBody2D` and `CharacterBody3D` in their physics callbacks.
Use collision layers and masks deliberately. Never assume an `Area2D` overlap is a physical
collision response.

## Determinism

Use a dedicated `RandomNumberGenerator` and expose its seed for procedural systems.
This makes bug reports reproducible and supports deterministic test cases.

## Persistence

Save stable identifiers and primitive state, not live Node references. Include a save schema
version and validate loaded data before applying it.
