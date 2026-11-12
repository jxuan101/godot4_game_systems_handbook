# Testing Strategy

## Test layers

1. **Pure logic tests:** timers, damage calculations, inventory capacity, weighted selection.
2. **Node integration tests:** signals, collisions, scene transitions, navigation.
3. **Gameplay test scenes:** verify feel, readability, and edge cases under real physics.
4. **Regression tests:** preserve bugs as repeatable test cases.

## Recommended frameworks

- [GUT](https://github.com/bitwes/Gut): GDScript unit testing.
- [GdUnit4](https://github.com/MikeSchulze/gdUnit4): unit and integration testing.

## Minimum test checklist for every system

- Valid input and expected behavior.
- Empty, null, or missing dependency.
- Boundary values (zero, maximum, negative where relevant).
- Repeated calls and state reset.
- Scene exit / node deletion during an operation.
- Save/load or multiplayer behavior if applicable.
- Signal emitted exactly when expected.

## Manual test scene convention

Keep test scenes under `project/scenes/tests/<system_name>/`. Use visible labels or debug
drawings to expose state while testing. Remove debug-only behavior from production scenes.
