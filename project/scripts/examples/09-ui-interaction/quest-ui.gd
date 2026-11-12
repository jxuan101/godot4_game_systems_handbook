# Godot 4 example. Attach to a node of the declared base type.
class_name ExampleQuestUi
extends Control

@export var list: ItemList
func render_quests(quests: Dictionary) -> void:
    if list == null: return
    list.clear()
    for id in quests:
        var quest: Dictionary = quests[id]
        list.add_item("%s%s" % ["✓ " if quest.get("complete", false) else "", str(id)])
