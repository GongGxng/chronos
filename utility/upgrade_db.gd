extends Node


const ICON_PATH = "res://player/attack/upgrade_icon/"
const WEAPON_PATH = "res://player/attack/weapon_icon/"

const UPGRADES = {
        "ice_cube1": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "ice_cube",
            "details": "A cube of ice is thrown at a random enemy",
            "level": "Level: 1",
            "prerequisite": [],
            "type": "weapon"
        },
        "ice_cube2": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "ice_cube",
            "details": "An addition ice cube is thrown",
            "level": "Level: 2",
            "prerequisite": ["ice_cube1"],
            "type": "weapon"
        },
        "ice_cube3": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "ice_cube",
            "details": "ice cubes now pass through another enemy and do + 3 damage",
            "level": "Level: 3",
            "prerequisite": ["ice_cube2"],
            "type": "weapon"
        },
        "ice_cube4": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "ice_cube",
            "details": "An additional 2 ice cubes are thrown",
            "level": "Level: 4",
            "prerequisite": ["ice_cube3"],
            "type": "weapon"
        },
        "star1": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "star",
            "details": "A magical star will follow you attacking enemies in a straight line",
            "level": "Level: 1",
            "prerequisite": [],
            "type": "weapon"
        },
        "star2": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "star",
            "details": "The star will now attack an additional enemy per attack",
            "level": "Level: 2",
            "prerequisite": ["star1"],
            "type": "weapon"
        },
        "star3": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "star",
            "details": "The star will attack another additional enemy per attack",
            "level": "Level: 3",
            "prerequisite": ["star2"],
            "type": "weapon"
        },
        "star4": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "star",
            "details": "The star now does + 5 damage per attack and causes 20% additional knockback",
            "level": "Level: 4",
            "prerequisite": ["star3"],
            "type": "weapon"
        },
        "speed1": {
            "icon": ICON_PATH + "boots.png",
            "displayname": "Speed",
            "details": "Movement Speed Increased by 50% of base speed",
            "level": "Level: 1",
            "prerequisite": [],
            "type": "upgrade"
        },
        "speed2": {
            "icon": ICON_PATH + "boots.png",
            "displayname": "Speed",
            "details": "Movement Speed Increased by an additional 50% of base speed",
            "level": "Level: 2",
            "prerequisite": ["speed1"],
            "type": "upgrade"
        },
        "speed3": {
            "icon": ICON_PATH + "boots.png",
            "displayname": "Speed",
            "details": "Movement Speed Increased by an additional 50% of base speed",
            "level": "Level: 3",
            "prerequisite": ["speed2"],
            "type": "upgrade"
        },
        "speed4": {
            "icon": ICON_PATH + "boots.png",
            "displayname": "Speed",
            "details": "Movement Speed Increased an additional 50% of base speed",
            "level": "Level: 4",
            "prerequisite": ["speed3"],
            "type": "upgrade"
        },
        "tome1": {
            "icon": ICON_PATH + "ขยาย1.png",
            "displayname": "Tome",
            "details": "Increases the size of weapon an additional 10% of their base size",
            "level": "Level: 1",
            "prerequisite": [],
            "type": "upgrade"
        },
        "tome2": {
            "icon": ICON_PATH + "ขยาย1.png",
            "displayname": "Tome",
            "details": "Increases the size of weapon an additional 10% of their base size",
            "level": "Level: 2",
            "prerequisite": ["tome1"],
            "type": "upgrade"
        },
        "tome3": {
            "icon": ICON_PATH + "ขยาย1.png",
            "displayname": "Tome",
            "details": "Increases the size of weapon an additional 10% of their base size",
            "level": "Level: 3",
            "prerequisite": ["tome2"],
            "type": "upgrade"
        },
        "tome4": {
            "icon": ICON_PATH + "ขยาย1.png",
            "displayname": "Tome",
            "details": "Increases the size of weapon an additional 10% of their base size",
            "level": "Level: 4",
            "prerequisite": ["tome3"],
            "type": "upgrade"
        },
        "scroll1": {
            "icon": ICON_PATH + "ตีไว.png",
            "displayname": "Scroll",
            "details": "Decreases of the cooldown of weapon by an additional 5% of their base time",
            "level": "Level: 1",
            "prerequisite": [],
            "type": "upgrade"
        },
        "scroll2": {
            "icon": ICON_PATH + "ตีไว.png",
            "displayname": "Scroll",
            "details": "Decreases of the cooldown of weapon by an additional 5% of their base time",
            "level": "Level: 2",
            "prerequisite": ["scroll1"],
            "type": "upgrade"
        },
        "scroll3": {
            "icon": ICON_PATH + "ตีไว.png",
            "displayname": "Scroll",
            "details": "Decreases of the cooldown of weapon by an additional 5% of their base time",
            "level": "Level: 3",
            "prerequisite": ["scroll2"],
            "type": "upgrade"
        },
        "scroll4": {
            "icon": ICON_PATH + "ตีไว.png",
            "displayname": "Scroll",
            "details": "Decreases of the cooldown of weapon by an additional 5% of their base time",
            "level": "Level: 4",
            "prerequisite": ["scroll3"],
            "type": "upgrade"
        },
        "ring1": {
            "icon": ICON_PATH + "ยิง2.png",
            "displayname": "Ring",
            "details": "Your weapon now spawn 1 more additional attack",
            "level": "Level: 1",
            "prerequisite": [],
            "type": "upgrade"
        },
        "ring2": {
            "icon": ICON_PATH + "ยิง2.png",
            "displayname": "Ring",
            "details": "Your weapon now spawn an additional attack",
            "level": "Level: 2",
            "prerequisite": ["ring1"],
            "type": "upgrade"
        },
        "armor": {
            "icon": ICON_PATH + "armor.png",
            "displayname": "Armor",
            "details": "Increase your Time N/A by 20.",
            "level": "N/A",
            "type": "item",
            },
    }