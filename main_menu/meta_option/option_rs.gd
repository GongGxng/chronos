extends Resource

class_name UpgradeOption_rs

@export var name_enum : NameEnum
@export var name: String
@export var name_dp: String
@export var description: String
@export var icon: Texture2D
@export var icon_hover: Texture2D
@export var cost: int
@export var level: int = 0
@export var max_level: int

enum NameEnum {
    none,
    grab_area,
    damage,
    attack_spd,
    atditionnal_attack,
    attack_size
}

func upgrade_type():
    match name_enum:
        1:
            name = "grab_area_lv"
            name_dp = "Grab Area"
        2:
            name = "damage_lv"
            name_dp = "Damage"
        3:
            name = "attack_spd_lv"
            name_dp = "Attack Speed"
        4:
            name = "atditional_attack_lv"
            name_dp = "Additional Attack"
        5:
            name = "attack_size_lv"
            name_dp = "Attack Size"
        _:
            name = "none"
            name_dp = "None"
    return name