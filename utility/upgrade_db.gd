extends Node


const ICON_PATH = "res://player/attack/upgrade_icon/"
const WEAPON_PATH = "res://player/attack/weapon_icon/"

const UPGRADES = {
        "katana1": {
            "icon": WEAPON_PATH + "katana.png",
            "displayname": "Katana",
            "details": "A katana slashes a random enemy",
            "level": "Level: 1",
            "prerequisite": [],
            "type": "weapon"
        },
        "katana2": {
            "icon": WEAPON_PATH + "katana.png",
            "displayname": "Katana",
            "details": "An additional katana slashes",
            "level": "Level: 2",
            "prerequisite": ["katana1"],
            "type": "weapon"
        },
        "katana3": {
            "icon": WEAPON_PATH + "katana.png",
            "displayname": "Katana",
            "details": "Katanas now pass through another enemy",
            "level": "Level: 3",
            "prerequisite": ["katana2"],
            "type": "weapon"
        },
        "katana4": {
            "icon": WEAPON_PATH + "katana.png",
            "displayname": "Katana",
            "details": "An additional 2 katanas are slashed",
            "level": "Level: 4",
            "prerequisite": ["katana3"],
            "type": "weapon"
        },
        "katana5": {
            "icon": WEAPON_PATH + "katana.png",
            "displayname": "Katana",
            "details": "Increases the damage of katanas",
            "level": "Level: 5",
            "prerequisite": ["katana4"],
            "type": "weapon"
        },
        "katana6": {
            "icon": WEAPON_PATH + "katana.png",
            "displayname": "Katana",
            "details": "An additional katana is slashed",
            "level": "Level: 6",
            "prerequisite": ["katana5"],
            "type": "weapon"
        },
        "katana7": {
            "icon": WEAPON_PATH + "katana.png",
            "displayname": "Katana",
            "details": "Katanas now pass through another enemy and do + 3 damage",
            "level": "Level: 7",
            "prerequisite": ["katana6"],
            "type": "weapon"
        },
        "ice_cube1": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "Ice cube",
            "details": "A cube of ice is thrown at a random enemy",
            "level": "Level: 1",
            "prerequisite": [],
            "type": "weapon"
        },
        "ice_cube2": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "Ice cube",
            "details": "An addition ice cube is thrown",
            "level": "Level: 2",
            "prerequisite": ["ice_cube1"],
            "type": "weapon"
        },
        "ice_cube3": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "Ice cube",
            "details": "ice cubes now pass through another enemy",
            "level": "Level: 3",
            "prerequisite": ["ice_cube2"],
            "type": "weapon"
        },
        "ice_cube4": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "Ice cube",
            "details": "An additional 2 ice cubes are thrown",
            "level": "Level: 4",
            "prerequisite": ["ice_cube3"],
            "type": "weapon"
        },
        "ice_cube5": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "Ice cube",
            "details": "Increases the damage of ice cubes",
            "level": "Level: 5",
            "prerequisite": ["ice_cube4"],
            "type": "weapon"
        },
        "ice_cube6": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "Ice cube",
            "details": "An additional ice cube is thrown",
            "level": "Level: 6",
            "prerequisite": ["ice_cube5"],
            "type": "weapon"
        },
        "ice_cube7": {
            "icon": WEAPON_PATH + "ice_cube.png",
            "displayname": "Ice cube",
            "details": "ice cubes now pass through another enemy and do + 3 damage",
            "level": "Level: 7",
            "prerequisite": ["ice_cube6"],
            "type": "weapon"
        },
        "star1": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "Star",
            "details": "A magical star will follow you attacking enemies in a straight line",
            "level": "Level: 1",
            "prerequisite": [],
            "type": "weapon"
        },
        "star2": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "Star",
            "details": "The star will now attack an additional enemy per attack",
            "level": "Level: 2",
            "prerequisite": ["star1"],
            "type": "weapon"
        },
        "star3": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "Star",
            "details": "The star will attack another additional enemy per attack",
            "level": "Level: 3",
            "prerequisite": ["star2"],
            "type": "weapon"
        },
        "star4": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "Star",
            "details": "The star now does + 5 damage per attack",
            "level": "Level: 4",
            "prerequisite": ["star3"],
            "type": "weapon"
        },
        "star5": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "Star",
            "details": "The star will now attack an additional enemy per attack + 1 more star",
            "level": "Level: 5",
            "prerequisite": ["star4"],
            "type": "weapon"
        },
        "star6": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "Star",
            "details": "The star will attack another additional enemy per attack",
            "level": "Level: 6",
            "prerequisite": ["star5"],
            "type": "weapon"
        },
        "star7": {
            "icon": WEAPON_PATH + "star.png",
            "displayname": "Star",
            "details": "The star now does + 5 damage per attack",
            "level": "Level: 7",
            "prerequisite": ["star6"],
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
        "armor1": {
            "icon": ICON_PATH + "armor.png",
            "displayname": "Armor",
            "details": "Reduce damage taken",
            "level": "1",
            "prerequisite": [],
            "type": "item",
        },
        "armor2": {
            "icon": ICON_PATH + "armor.png",
            "displayname": "Armor",
            "details": "Reduce damage taken",
            "level": "2",
            "prerequisite": ["armor1"],
            "type": "item",
        },
        "armor3": {
            "icon": ICON_PATH + "armor.png",
            "displayname": "Armor",
            "details": "Reduce damage taken",
            "level": "3",
            "prerequisite": ["armor2"],
            "type": "item",
        },
        "armor4": {
            "icon": ICON_PATH + "armor.png",
            "displayname": "Armor",
            "details": "Reduce damage taken",
            "level": "4",
            "prerequisite": ["armor3"],
            "type": "item",
        },
        "food": {
            "icon": ICON_PATH + "none.png",
            "displayname": "Food",
            "details": "None",
            "level": "None",
            "prerequisite": [],
            "type": "item",
        }
    }