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

"""
grab_area_lv": 0,
damage_lv": 0,
attack_spd_lv": 0,
additional_attack_lv": 0,
attack_size_lv": 0,
increase_time_start_lv": 0,
reduce_damage_taken_lv": 0,
max_time_lv": 0
boost_coins_lv": 0
"""

enum NameEnum {
    none,
    grab_area,
    damage,
    attack_spd,
    additional_attack,
    attack_size,
    increase_time_start,
    reduce_damage_taken,
    max_time,
    boost_coins_lv
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
            name = "additional_attack_lv"
            name_dp = "Additional Attack"
        5:
            name = "attack_size_lv"
            name_dp = "Attack Size"
        6:
            name = "increase_time_start_lv"
            name_dp = "Starter Time"
        7:
            name = "reduce_damage_taken_lv"
            name_dp = "Armor"
        8:
            name = "max_time_lv"
            name_dp = "Max Time"
        9:
            name = "boost_coins_lv"
            name_dp = "Coins Boost"
        _:
            name = "none"
            name_dp = "None"
    return name