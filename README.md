# Godot 4 Game Systems Handbook

A modular learning/reference repository for designing reusable gameplay systems in **Godot 4.x**.
It catalogs 80 systems across movement, combat, procedural generation, inventory, AI, world
simulation, progression, architecture, UI, and advanced gameplay.

## What's actually included

- 80 system-specific Markdown guides with purpose, suggested scene shape, design notes,
  a starter scaffold, generic test checklist, and integration guidance.
- A small set of concrete reusable GDScript examples for foundational patterns:
  platformer movement, top-down movement, health, projectiles, inventory, item Resources,
  a simple state machine, cave generation, seeded weighted selection, and scene transitions.
- A runnable platformer sandbox project demonstrating basic movement, jumping, coyote time,
  jump buffering, and collision with a floor and platforms.
- Architecture guidance, a testing strategy, and an implementation roadmap.

## Important scope limitation

The 80 guides are **not** 80 complete, production-ready implementations. Most system guides
provide a design scaffold and implementation direction rather than a full working feature.
Only the scripts listed under `project/scripts/README.md` are supplied as concrete starter
implementations. They still need project-specific integration, validation, and testing.

The included scripts have not been executed in the Godot editor as part of this package build.
Treat them as starter code and run/import the project in your target Godot 4.x version before
using them in a production game.

## How to use

1. Extract the repository.
2. Open the `project/` directory in Godot 4.x.
3. Run the project. Use **A/D** or **Left/Right** to move and **Space** to jump.
4. Browse `handbook/README.md` for the full 80-system catalog.
5. Use the relevant guide as a design starting point, then implement and test the system in
   a minimal isolated scene before integrating it into a game.

## Repository structure

```text
godot4-game-systems-handbook/
├── README.md
├── AUDIT.md
├── handbook/
│   ├── README.md
│   ├── architecture.md
│   ├── testing.md
│   ├── implementation-roadmap.md
│   └── systems/
└── project/
    ├── project.godot
    ├── scenes/
    └── scripts/
```

## Compatibility

Target: Godot 4.x / GDScript 2.0. Minor-version API or serialization differences may apply.

## Working code examples

Every one of the 80 system guides now has a corresponding system-specific GDScript example under `project/scripts/examples/`. These scripts implement focused core behavior (movement, combat, procedural generation, inventory, AI, world simulation, progression, architecture, UI, and advanced mechanics). They are intentionally examples rather than drop-in complete games: scene composition, collision layers, art, animations, networking setup, and game-specific balancing remain project integration work. Start at `project/scripts/examples/README.md`.

## Validation status

The repository has been checked for guide-to-script coverage, broken local script references, duplicate `class_name` declarations, missing referenced input actions, placeholder bodies, and archive integrity. A Godot 4 executable is not available in this environment, so editor import, GDScript parser validation, and live gameplay tests could not be run here. Run the project in Godot 4 and follow each guide's test checklist before shipping.
