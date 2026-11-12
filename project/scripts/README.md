# Project scripts

- `demo_player.gd`: playable 2D platformer demo controller used by `scenes/demo.tscn`.
- `examples/`: 80 concrete, system-specific Godot 4 examples, one for every handbook guide. See `examples/README.md` for the index.
- Other folders contain reusable starter implementations used by the handbook architecture examples.

Attach each example to the node type declared by its `extends` line. Configure the exported properties and required child references in the Inspector. Input-driven examples use actions defined in `project.godot`; some examples also require a collision shape, collision mask, target group, or exported scene/resource reference.
