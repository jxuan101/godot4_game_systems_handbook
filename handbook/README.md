# Handbook Catalog

80 systems in 10 categories. Each system guide includes purpose, scene architecture, implementation guidance, reuse notes, and a test checklist.

## Player Movement & Controllers

- [2D Platformer Movement](systems/01-player-movement/2d-platformer-movement/README.md) — Horizontal acceleration, friction, gravity, jumping, coyote time, and jump buffering.
- [3D Character Movement](systems/01-player-movement/3d-character-movement/README.md) — Camera-relative movement, acceleration, gravity, jumping, and sprinting.
- [Top-Down Movement](systems/01-player-movement/top-down-movement/README.md) — Eight-direction movement with normalized diagonal speed and optional acceleration.
- [Dash & Dodge](systems/01-player-movement/dash-dodge/README.md) — A timed movement burst with direction capture, cooldown, and interruption rules.
- [Double Jump](systems/01-player-movement/double-jump/README.md) — Track remaining jumps and reset the count on landing.
- [Wall Jump & Climb](systems/01-player-movement/wall-jump-climb/README.md) — Detect walls, attach to climbable surfaces, and launch away from walls.
- [Swimming & Underwater Movement](systems/01-player-movement/swimming/README.md) — Switch between grounded and buoyant movement while inside water areas.
- [Grappling Hook Movement](systems/01-player-movement/grappling-hook/README.md) — Attach to a grapple point and apply a spring-like pull toward the anchor.

## Combat Systems

- [Melee Combat](systems/02-combat/melee-combat/README.md) — Attack windows, hit detection, cooldowns, and attack state.
- [Ranged Combat & Projectiles](systems/02-combat/ranged-projectiles/README.md) — Spawn projectiles with direction, speed, lifetime, and collision handling.
- [Hitboxes & Hurtboxes](systems/02-combat/hitboxes-hurtboxes/README.md) — Separate attack detection from damage reception.
- [Health & Damage](systems/02-combat/health-damage/README.md) — Health, damage validation, healing, death signaling, and invulnerability.
- [Combo System](systems/02-combat/combo-system/README.md) — Chain attacks within timing windows and reset the chain after timeout.
- [Blocking, Parrying & Dodging](systems/02-combat/block-parry-dodge/README.md) — Resolve incoming attacks against defensive states and timing windows.
- [Abilities & Cooldowns](systems/02-combat/abilities-cooldowns/README.md) — Data-driven abilities with resource costs and cooldown timers.
- [Status Effects & Elemental Damage](systems/02-combat/status-effects/README.md) — Apply timed effects such as burn, slow, poison, and resistance modifiers.

## Procedural Generation

- [Random Room Generation](systems/03-procedural-generation/random-room-generation/README.md) — Place rooms from reusable scenes while preventing unwanted overlaps.
- [Procedural Dungeon Generation](systems/03-procedural-generation/dungeon-generation/README.md) — Generate a connected room graph and carve corridors between rooms.
- [Procedural Cave Generation](systems/03-procedural-generation/cave-generation/README.md) — Use cellular automata to create cave-like solid/empty regions.
- [Procedural Terrain Generation](systems/03-procedural-generation/terrain-generation/README.md) — Generate height values from noise and build terrain geometry.
- [Procedural Level Layouts](systems/03-procedural-generation/level-layouts/README.md) — Generate a deterministic level layout from a seed.
- [Random Loot Generation](systems/03-procedural-generation/loot-generation/README.md) — Choose drops from weighted loot entries.
- [Enemy Spawning & Distribution](systems/03-procedural-generation/enemy-spawning/README.md) — Spawn enemies at validated spawn markers with density limits.
- [Procedural Obstacles & Hazards](systems/03-procedural-generation/obstacles-hazards/README.md) — Populate valid positions with obstacles while preserving safe paths.

## Inventory & Item Systems

- [Grid-Based Inventory](systems/04-inventory-items/grid-inventory/README.md) — Store item stacks in slots and expose add/remove operations.
- [Equipment Systems](systems/04-inventory-items/equipment/README.md) — Equip items into named slots and derive character modifiers.
- [Item Stacking](systems/04-inventory-items/item-stacking/README.md) — Merge compatible stacks up to a maximum stack size.
- [Item Rarity & Attributes](systems/04-inventory-items/item-rarity/README.md) — Represent rarity and rolled attributes as data rather than hardcoded branches.
- [Crafting Systems](systems/04-inventory-items/crafting/README.md) — Validate ingredients, consume inputs, and produce an output item.
- [Loot Tables](systems/04-inventory-items/loot-tables/README.md) — Define weighted drop entries and roll them from a seeded RNG.
- [Shops & Trading](systems/04-inventory-items/shops-trading/README.md) — Validate currency and stock before completing a purchase.
- [Item Pickup & Dropping](systems/04-inventory-items/pickup-drop/README.md) — Detect nearby item pickups and transfer item data into inventory.

## Enemy AI

- [Finite State Machine AI](systems/05-enemy-ai/finite-state-machine/README.md) — Represent idle, patrol, chase, attack, and hurt states with explicit transitions.
- [Behavior Tree AI](systems/05-enemy-ai/behavior-trees/README.md) — Compose reusable condition, sequence, selector, and action nodes.
- [Enemy Patrol Systems](systems/05-enemy-ai/enemy-patrol/README.md) — Move between patrol points and pause or reverse at endpoints.
- [Enemy Detection & Perception](systems/05-enemy-ai/perception/README.md) — Detect targets by range and optionally validate line of sight.
- [Pathfinding & Navigation](systems/05-enemy-ai/pathfinding/README.md) — Request paths and move toward the next navigation target.
- [Enemy Combat Behavior](systems/05-enemy-ai/enemy-combat-ai/README.md) — Choose attacks based on range, cooldown, and target state.
- [Boss AI & Attack Patterns](systems/05-enemy-ai/boss-ai/README.md) — Sequence telegraphed phases and attacks using timers and state transitions.
- [Group & Squad AI](systems/05-enemy-ai/squad-ai/README.md) — Coordinate shared target selection and assign roles to squad members.

## World & Environment

- [Day & Night Cycle](systems/06-world-environment/day-night/README.md) — Advance a normalized time-of-day value and emit phase changes.
- [Weather Systems](systems/06-world-environment/weather/README.md) — Transition between weather states and broadcast intensity changes.
- [Dynamic Lighting](systems/06-world-environment/dynamic-lighting/README.md) — Drive light energy and color from world time or gameplay events.
- [Destructible Environments](systems/06-world-environment/destructible-environment/README.md) — Track durability and replace or remove objects when destroyed.
- [Interactive Objects](systems/06-world-environment/interactive-objects/README.md) — Use a shared interaction interface for doors, switches, and pickups.
- [Environmental Hazards](systems/06-world-environment/environment-hazards/README.md) — Apply periodic damage or movement effects while an actor overlaps a hazard.
- [World Transitions](systems/06-world-environment/world-transitions/README.md) — Coordinate fade-out, scene change, and fade-in.
- [Chunk-Based World Loading](systems/06-world-environment/chunk-loading/README.md) — Load and unload world chunks around the active player.

## Progression & Gameplay Loops

- [Experience & Leveling](systems/07-progression/experience-leveling/README.md) — Accumulate XP, calculate thresholds, and emit level-up events.
- [Skill Trees](systems/07-progression/skill-trees/README.md) — Represent prerequisite nodes and validate unlock points.
- [Quest Systems](systems/07-progression/quests/README.md) — Track objectives and quest states using event-driven progress.
- [Achievement Systems](systems/07-progression/achievements/README.md) — Evaluate achievement criteria and persist unlock state.
- [Dialogue Systems](systems/07-progression/dialogue/README.md) — Represent dialogue nodes, choices, and branching conditions.
- [Reputation & Faction Systems](systems/07-progression/factions-reputation/README.md) — Track faction scores and map scores to relationship tiers.
- [Unlockable Content](systems/07-progression/unlockables/README.md) — Gate content behind flags, achievements, or progression requirements.
- [Procedural Missions](systems/07-progression/procedural-missions/README.md) — Compose mission objectives from validated templates.

## Game Architecture & Infrastructure

- [Scene Management](systems/08-architecture/scene-management/README.md) — Centralize scene transitions and prevent duplicate transition requests.
- [Save & Load Systems](systems/08-architecture/save-load/README.md) — Serialize versioned game state to user storage and validate loaded data.
- [Event Bus & Signal Architecture](systems/08-architecture/event-bus/README.md) — Use a small autoload for decoupled gameplay events.
- [Object Pooling](systems/08-architecture/object-pooling/README.md) — Reuse frequently spawned nodes instead of repeatedly instantiating them.
- [Component-Based Architecture](systems/08-architecture/component-architecture/README.md) — Compose actors from focused child nodes with narrow responsibilities.
- [Resource-Based Data Management](systems/08-architecture/resource-data/README.md) — Store reusable item, enemy, weapon, and ability definitions as custom Resources.
- [Input Management](systems/08-architecture/input-management/README.md) — Centralize rebinding, input queries, and controller-friendly actions.
- [Audio Management](systems/08-architecture/audio-management/README.md) — Centralize music and sound playback with bus routing and volume settings.

## UI & Interaction

- [HUD Systems](systems/09-ui-interaction/hud/README.md) — Display health, stamina, ammo, and contextual gameplay state.
- [Main Menu & Pause Menu](systems/09-ui-interaction/menus/README.md) — Switch menu panels and pause the SceneTree safely.
- [Dialogue UI](systems/09-ui-interaction/dialogue-ui/README.md) — Render dialogue text, choices, and speaker information.
- [Drag-and-Drop Interfaces](systems/09-ui-interaction/drag-drop/README.md) — Transfer item data between UI slots using Godot drag-and-drop callbacks.
- [Tooltips & Item Descriptions](systems/09-ui-interaction/tooltips/README.md) — Show contextual information after hover or focus delay.
- [Notification Systems](systems/09-ui-interaction/notifications/README.md) — Queue short-lived messages and display them without overlap.
- [Quest Tracking UI](systems/09-ui-interaction/quest-ui/README.md) — Subscribe to quest updates and render active objectives.
- [Dynamic Health & Stamina Bars](systems/09-ui-interaction/health-bars/README.md) — Bind progress bars to actor signals and clamp displayed values.

## Advanced Gameplay Systems

- [Physics-Based Puzzles](systems/10-advanced/physics-puzzles/README.md) — Build pushable objects, pressure plates, and physics-triggered puzzle logic.
- [Stealth & Visibility](systems/10-advanced/stealth/README.md) — Calculate visibility from distance, occlusion, lighting, and actor stance.
- [Time Manipulation](systems/10-advanced/time-manipulation/README.md) — Control selected simulation groups with configurable time scale.
- [Grappling & Rope Physics](systems/10-advanced/rope-physics/README.md) — Draw a rope between anchors and constrain its length with physics forces.
- [Vehicle Systems](systems/10-advanced/vehicles/README.md) — Configure acceleration, steering, braking, and traction.
- [Multiplayer Synchronization](systems/10-advanced/multiplayer/README.md) — Define authority, replicated state, and remote procedure call boundaries.
- [Replay & Ghost Systems](systems/10-advanced/replay-ghost/README.md) — Record timestamped player transforms and replay them as a ghost.
- [Dynamic Difficulty Adjustment](systems/10-advanced/dynamic-difficulty/README.md) — Adjust bounded difficulty parameters from player performance signals.
