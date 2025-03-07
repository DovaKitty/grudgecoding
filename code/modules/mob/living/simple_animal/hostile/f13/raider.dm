// IN THIS FILE: -All Raider Mobs

///////////////////
// BASIC RAIDERS //
///////////////////

// BASIC MELEE RAIDER
/mob/living/simple_animal/hostile/raider
	name = "Raider"
	desc = "Another murderer churned out by the wastes."
	icon = 'icons/fallout/mobs/humans/raider.dmi'
	icon_state = "raider_melee"
	icon_living = "raider_melee"
	icon_dead = "raider_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	turns_per_move = 5
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 100
	health = 100
	melee_damage_lower = 5
	melee_damage_upper = 14
	attack_verb_simple = "clobbers"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	a_intent = INTENT_HARM
	faction = list("raider")
	check_friendly_fire = TRUE
	status_flags = CANPUSH
	del_on_death = FALSE
	loot = list(/obj/item/melee/onehanded/knife/survival, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 3.1
	waddle_amount = 2
	waddle_up_time = 1
	waddle_side_time = 1
	retreat_distance = 1 //mob retreats 1 tile when in min distance
	minimum_distance = 1 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	variation_list = list(
		MOB_NAME_FROM_GLOBAL_LIST(\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_MALE, 1)\
		))

/obj/effect/mob_spawn/human/corpse/raider
	name = "Raider"
	uniform = /obj/item/clothing/under/f13/rag
	suit = /obj/item/clothing/suit/armor/medium/raider/iconoclast
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather
	head = /obj/item/clothing/head/helmet/f13/firefighter

/mob/living/simple_animal/hostile/raider/Aggro()
	. = ..()
	if(.)
		return
	summon_backup(15)
	if(!ckey)
		say(pick("*insult", "Fuck off!!", "Back off!!" , "Keep moving!!", "Get lost, asshole!!", "Call a doctor, we got a bleeder!!", "Fuck around and find out!!" ))

// THIEF RAIDER - nabs stuff and runs
/mob/living/simple_animal/hostile/raider/thief
	desc = "Another murderer churned out by the wastes. This one looks like they have sticky fingers..."

/mob/living/simple_animal/hostile/raider/thief/movement_delay()
	return -2

/mob/living/simple_animal/hostile/raider/thief/AttackingTarget()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.stat == SOFT_CRIT)
			var/back_target = H.back
			if(back_target)
				H.dropItemToGround(back_target, TRUE)
				src.transferItemToLoc(back_target, src, TRUE)
			var/belt_target = H.belt
			if(belt_target)
				H.dropItemToGround(belt_target, TRUE)
				src.transferItemToLoc(belt_target, src, TRUE)
			var/shoe_target = H.shoes
			if(shoe_target)
				H.dropItemToGround(shoe_target, TRUE)
				src.transferItemToLoc(shoe_target, src, TRUE)
			retreat_distance = 50
		else
			. = ..()

/mob/living/simple_animal/hostile/raider/thief/death(gibbed)
	for(var/obj/I in contents)
		src.dropItemToGround(I)
	. = ..()

// BASIC RANGED RAIDER
/mob/living/simple_animal/hostile/raider/ranged
	icon_state = "raider_ranged"
	icon_living = "raider_ranged"
	ranged = TRUE
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 85
	health = 85
	rapid_melee = 2
	melee_queue_distance = 5
	move_to_delay = 2.8 //faster than average, but not a lot
	retreat_distance = 1 //mob retreats 1 tile when in min distance
	minimum_distance = 1 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/c9mm/simple
	projectilesound = 'sound/f13weapons/ninemil.ogg'
	loot = list(/obj/effect/spawner/lootdrop/f13/npc_raider, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE
	variation_list = list(
		MOB_NAME_FROM_GLOBAL_LIST(\
			MOB_RANDOM_NAME(MOB_NAME_RANDOM_FEMALE, 1)\
		))
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_LIGHT_RANGE_DISTANT)
	)


// LEGENDARY MELEE RAIDER
/mob/living/simple_animal/hostile/raider/legendary
	name = "Legendary Raider"
	desc = "Another murderer churned out by the wastes - this one seems a bit faster than the average..."
	color = "#FFFF00"
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 300
	health = 300
	speed = 1.2
	obj_damage = 300
	rapid_melee = 1
	loot = list(/obj/item/melee/onehanded/knife/survival, /obj/item/reagent_containers/food/snacks/kebab/human, /obj/item/stack/f13Cash/random/high)
	footstep_type = FOOTSTEP_MOB_SHOE
	sneak_detection_threshold = HARD_CHECK
	sneak_roll_modifier = DIFFICULTY_CHALLENGE

// LEGENDARY RANGED RAIDER
/mob/living/simple_animal/hostile/raider/ranged/legendary
	name = "Legendary Raider"
	desc = "Another murderer churned out by the wastes, wielding a decent pistol and looking very strong"
	color = "#FFFF00"
	mob_armor = ARMOR_VALUE_RAIDER_LEATHER_JACKET
	maxHealth = 240
	health = 240
	retreat_distance = 1
	minimum_distance = 2
	rapid_melee = 1
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	sight_shoot_delay_time = 0 SECONDS
	projectiletype = /obj/item/projectile/bullet/m44/simple
	projectilesound = 'sound/f13weapons/44mag.ogg'
	extra_projectiles = 1
	obj_damage = 300
	loot = list(/obj/item/gun/ballistic/revolver/m29, /obj/item/stack/f13Cash/random/high)
	footstep_type = FOOTSTEP_MOB_SHOE
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_HEAVY_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_HEAVY_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_HEAVY_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_HEAVY_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_HEAVY_RANGE_DISTANT)
	)
	sneak_detection_threshold = HARD_CHECK
	sneak_roll_modifier = DIFFICULTY_CHALLENGE

// RAIDER BOSS
/mob/living/simple_animal/hostile/raider/ranged/boss
	name = "Raider Boss"
	icon_state = "raiderboss"
	icon_living = "raiderboss"
	icon_dead = "raiderboss_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 150
	health = 150
	extra_projectiles = 2
	rapid_melee = 1
	waddle_amount = 4
	waddle_up_time = 2
	waddle_side_time = 1
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/c45/simple
	loot = list(/obj/item/gun/ballistic/automatic/smg/greasegun, /obj/item/clothing/head/helmet/f13/combat/mk2/raider, /obj/effect/spawner/lootdrop/f13/armor/randomraiderchest, /obj/item/clothing/under/f13/ravenharness, /obj/item/stack/f13Cash/random/high)
	footstep_type = FOOTSTEP_MOB_SHOE
	move_to_delay = 4.0 //faster than average, but not a lot
	retreat_distance = 4 //mob retreats 1 tile when in min distance
	minimum_distance = 2 //Mob pushes up to melee, then backs off to avoid player attack?
	aggro_vision_range = 6 //mob waits to attack if the player chooses to close distance, or if the player attacks first.
	vision_range = 8 //will see the player at max view range, and communicate that they've been seen but won't aggro unless they get closer.
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
	)

	variation_list = list(
		MOB_RETREAT_DISTANCE_LIST(0, 1, 3, 4),
		MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(50),
		MOB_MINIMUM_DISTANCE_LIST(0, 2, 4),
		MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(40),
	)
	sneak_detection_threshold = HARD_CHECK
	sneak_roll_modifier = DIFFICULTY_CHALLENGE

/mob/living/simple_animal/hostile/raider/ranged/boss/Aggro()
	. = ..()
	if(.)
		return
	summon_backup(15)
	if(!ckey)
		say("KILL 'EM, FELLAS!")

/mob/living/simple_animal/hostile/raider/ranged/boss/mangomatt
	name = "Mango Mathew and his Merry Meth Madlads"
	desc = "Hi, Mango Mathew and his Merry Meth Madlads."
	icon_state = "mango_matt"
	icon_living = "mango_matt"
	icon_dead = "mango_matt_dead"
	gender = MALE
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 165
	health = 165
	extra_projectiles = 2
	ranged_cooldown_time = 1 SECONDS
	sight_shoot_delay_time = 0 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_FAST
	speak_emote = list(
		"growls",
		"murrs",
		"purrs",
		"mrowls",
		"yowls",
		"prowls"
		)
	emote_see = list(
		"laughs",
		"nyas",
		""
		)
	attack_verb_simple = list(
		"claws",
		"maims",
		"bites",
		"mauls",
		"slashes",
		"thrashes",
		"bashes",
		"glomps",
		"beats their greasegun against the face of"
		)
	variation_list = list() // so he keeps his stupid name

/mob/living/simple_animal/hostile/raider/ranged/boss/mangomatt/Aggro()
	..()
	summon_backup(15)
	say(pick(\
		"*nya",\
		"*mrowl",\
		"*lynx",\
		"*cougar",\
		"*growl",\
		"*come",\
		"Fuck em' up!"\
		))

/mob/living/simple_animal/hostile/raider/ranged/boss/blueberrybates
	name = "Blueberry Bates and his Bottom-Feeder Buys"
	desc = "Hello, Blueberry Bates and his Bottom-Feeder Buys. Has a shotgun with APDS incendiary slugs and is ready to fucking kill you."
	icon_state = "blueberry_bates"
	icon_living = "blueberry_bates"
	icon_dead = "blueberry_bates_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	move_to_delay = 4 //S L O W
	sight_shoot_delay_time = 0 SECONDS
	ranged_cooldown_time = 1 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/incendiary/shotgun
	projectilesound = 'sound/f13weapons/shotgun.ogg'
	maxHealth = 200 //bit beefier since his arena is significantly shittier for him and he's more of an annoyance
	health = 200
	extra_projectiles = 0
	retreat_distance = 3
	minimum_distance = 3
	loot = list(/obj/item/stack/f13Cash/random/high, /obj/item/ammo_box/shotgun/incendiary, /obj/item/gun/ballistic/shotgun/police)
	speak_emote = list(
		"mutters",
		"counts his caps to himself",
		"yells at someone to pick up the pace",
		"barks",
		"grumbles",
		"grouches"
		)
	emote_see = list(
		"chitters",
		"idly gnaws on a hat",
		)
	attack_verb_simple = list(
		"bayonets",
		"smacks",
		"bites",
		"mauls",
		"slashes",
		"thrashes",
		"bashes",
		"glomps",
		"robusts on"
		)
	variation_list = list() // so he keeps his stupid name

/mob/living/simple_animal/hostile/raider/ranged/boss/blueberrybates/Aggro()
	..()
	summon_backup(15)
	say(pick(\
		"TO ME, BOYS!",\
		"KICK THEIR ASS!",\
		"Fuck 'em up!",\
		"*chitter",\
		"*kyaa",\
		"*come",\
		"YOU'RE ABOUT TO GET A DISCOUNT ON A GRAVE, BUDDY!",\
		))

// RANGED RAIDER WITH ARMOR
/mob/living/simple_animal/hostile/raider/ranged/metalranged
	icon_state = "metal_raider"
	icon_living = "metal_raider"
	icon_dead = "metal_raider_dead"
	mob_armor = ARMOR_VALUE_RAIDER_METAL_ARMOR
	maxHealth = 60
	health = 60
	rapid_melee = 1
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/c45/simple
	projectilesound = 'sound/weapons/gunshot.ogg'
	loot = list(/obj/item/gun/ballistic/automatic/pistol/m1911/custom, /obj/item/clothing/suit/armor/heavy/metal/reinforced, /obj/item/clothing/head/helmet/knight/f13/metal, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_MEDIUM_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_MEDIUM_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_MEDIUM_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(PISTOL_MEDIUM_DISTANT_SOUND),
		SP_DISTANT_RANGE(PISTOL_MEDIUM_RANGE_DISTANT)
	)

// FIREFIGHTER RAIDER
/mob/living/simple_animal/hostile/raider/firefighter
	icon_state = "firefighter_raider"
	icon_living = "firefighter_raider"
	icon_dead = "firefighter_raider_dead"
	mob_armor = ARMOR_VALUE_RAIDER_ARMOR
	maxHealth = 100
	health = 100
	loot = list(/obj/item/twohanded/fireaxe, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE
	rapid_melee = 1

// BIKER RAIDER
/mob/living/simple_animal/hostile/raider/ranged/biker
	icon_state = "biker_raider"
	icon_living = "biker_raider"
	icon_dead = "biker_raider_dead"
	melee_damage_lower = 10
	melee_damage_upper = 20
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 125
	health = 125
	rapid_melee = 1
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/a762/sport/simple
	projectilesound = 'sound/f13weapons/magnum_fire.ogg'
	loot = list(/obj/item/gun/ballistic/revolver/thatgun, /obj/item/clothing/suit/armor/medium/combat/rusted, /obj/item/clothing/head/helmet/f13/combat/raider, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE
	projectile_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(RIFLE_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(RIFLE_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(RIFLE_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(RIFLE_LIGHT_DISTANT_SOUND),
		SP_DISTANT_RANGE(RIFLE_LIGHT_RANGE_DISTANT)
	)

/obj/effect/mob_spawn/human/corpse/raider/ranged/biker
	uniform = /obj/item/clothing/under/f13/ncrcf
	suit = /obj/item/clothing/suit/armor/medium/combat/rusted
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	head = /obj/item/clothing/head/helmet/f13/combat/raider
	neck = /obj/item/clothing/neck/mantle/brown

// YANKEE RAIDER

/mob/living/simple_animal/hostile/raider/baseball
	icon_state = "baseball_raider"
	icon_living = "baseball_raider"
	icon_dead = "baseball_raider_dead"
	retreat_distance = 1
	minimum_distance = 1
	melee_damage_lower = 15
	melee_damage_upper = 33
	mob_armor = ARMOR_VALUE_RAIDER_ARMOR
	maxHealth = 125
	health = 125
	rapid_melee = 1
	loot = list(/obj/item/twohanded/baseball, /obj/item/stack/f13Cash/random/med)
	footstep_type = FOOTSTEP_MOB_SHOE


/obj/effect/mob_spawn/human/corpse/raider/baseball
	uniform = /obj/item/clothing/under/f13/mechanic
	suit = /obj/item/clothing/suit/armor/medium/raider/yankee
	shoes = /obj/item/clothing/shoes/f13/explorer
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	head = /obj/item/clothing/head/helmet/f13/raider/yankee

// TRIBAL RAIDER

/mob/living/simple_animal/hostile/raider/tribal
	icon_state = "tribal_raider"
	icon_living = "tribal_raider"
	icon_dead = "tribal_raider_dead"
	mob_armor = ARMOR_VALUE_RAIDER_ARMOR
	maxHealth = 125
	health = 125
	melee_damage_lower = 12
	melee_damage_upper = 37
	loot = list(/obj/item/twohanded/spear)
	footstep_type = FOOTSTEP_MOB_SHOE
	rapid_melee = 1

/obj/effect/mob_spawn/human/corpse/raider/tribal
	uniform = /obj/item/clothing/under/f13/raiderrags
	suit = /obj/item/clothing/suit/armor/light/tribal
	shoes = /obj/item/clothing/shoes/f13/rag
	mask = /obj/item/clothing/mask/facewrap

//////////////
// SULPHITE //
//////////////

/mob/living/simple_animal/hostile/raider/sulphite
	name = "Sulphite Salter"
	desc = "A raider with armour that for some reason, has a small diesel generator installed. Wields a ripper"
	icon_state = "sulphite"
	icon_living = "sulphite"
	icon_dead = "sulphite_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 135
	health = 135
	rapid_melee = 1
	melee_damage_lower = 15
	melee_damage_upper = 37
	loot = list(/obj/item/stack/f13Cash/random/low)
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/raider/ranged/sulphite
	name = "Sulphite Pepperer"
	desc = "A raider with armour that for some reason, has a small diesel generator installed. Wields an uzi"
	icon_state = "sulphite_ranged"
	icon_living = "sulphite_ranged"
	icon_dead = "sulphite_dead"
	mob_armor = ARMOR_VALUE_RAIDER_METAL_ARMOR
	maxHealth = 80
	health = 80
	extra_projectiles = 2
	loot = list(/obj/item/gun/ballistic/automatic/pistol/m1911/custom, /obj/item/clothing/suit/armor/heavy/metal/sulphite, /obj/item/clothing/head/helmet/f13/sulphitehelm, /obj/item/stack/f13Cash/random/med)

/mob/living/simple_animal/hostile/raider/ranged/sulphite/heavy
	name = "Sulphite Seasoner"
	desc = "A raider with a fully sealed suit of armour that for some reason, has a small diesel generator and a gas mask installed. Carries an incinerator."
	icon_state = "sulphite_heavy"
	icon_living = "sulphite_heavy"
	icon_dead = "sulphite_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 155
	health = 155
	rapid_melee = 1
	melee_damage_lower = 15
	melee_damage_upper = 37
	loot = list(/obj/item/stack/f13Cash/random/low)
	footstep_type = FOOTSTEP_MOB_SHOE
	projectiletype = /obj/item/projectile/incendiary/flamethrower
	projectilesound = 'sound/weapons/flamethrower.ogg'

/mob/living/simple_animal/hostile/raider/sulphite/boss
	name = "Sulphite Boss"
	desc = "A Sulphite Boss, decked out in salvaged T-45d. The port for the fusion core has been torn away, replaced with a lead-lined fission generator. He... Hasn't got a weapon?"
	icon_state = "sulphite_boss"
	icon_living = "sulhpite_boss"
	icon_dead = "sulphite_boss_dead"
	mob_armor = ARMOR_VALUE_ROBOT_SECURITY
	maxHealth = 300
	health = 300
	rapid_melee = 1
	loot = list(/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b/hotrod, /obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/hotrod, /obj/item/stack/f13Cash/random/banker)
	melee_damage_lower = 30
	melee_damage_upper = 49 //would be higher, but I think it'll deal 50 of each type
	melee_damage_type = list(BRUTE, BURN)//his punches are literally steampowered
	environment_smash = ENVIRONMENT_SMASH_RWALLS

/////////////
// JUNKERS //
/////////////

/mob/living/simple_animal/hostile/raider/junker
	name = "Junker"
	desc = "A raider from the Junker gang."
	faction = list("raider", "wastebot")
	icon_state = "junker_hijacker"
	icon_living = "junker_hijacker"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 150
	health = 150
	rapid_melee = 1
	melee_damage_lower = 18
	melee_damage_upper = 42
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/raider/ranged/junker
	name = "Junker"
	desc = "A raider from the Junker gang."
	faction = list("raider", "wastebot")
	icon_state = "junker_ranged"
	icon_living = "junker_ranged"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 100
	health = 100
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/raider/ranged/boss/junker
	name = "Junker Scrapper"
	desc = "A Junker outfitted in reinforced combat raider armor with extra metal plates and an armoured duster."
	icon_state = "junker_scrapper"
	icon_living = "junker_scrapper"
	icon_dead = "junker_dead"
	faction = list("raider", "wastebot")
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 165
	health = 165
	damage_coeff = list(BRUTE = 1, BURN = 0.75, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	rapid_melee = 1
	melee_damage_lower = 20
	melee_damage_upper = 38
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/raider/ranged/junker/scavver
	name = "Junker Scavver"
	desc = "A Junker outfitted in an armoured duster with a Pip-Boy 2000, the screen glowing red."
	icon_state = "junker_scavver"
	icon_living = "junker_scavver"
	icon_dead = "junker_dead"
	faction = list("raider", "wastebot")
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 165
	health = 165
	ranged = TRUE
	retreat_distance = 6
	minimum_distance = 8
	damage_coeff = list(BRUTE = 1, BURN = 0.75, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	rapid_melee = 1
	footstep_type = FOOTSTEP_MOB_SHOE
	ranged_cooldown_time = 2 SECONDS
	projectiletype = /obj/item/projectile/bullet/c45/op
	projectilesound = 'sound/weapons/gunshot.ogg'
	var/list/spawned_mobs = list()
	var/max_mobs = 2
	var/mob_types = list(/mob/living/simple_animal/hostile/raider/junker)
	var/spawn_time = 5 SECONDS
	var/spawn_text = "appears from"
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/raider/ranged/junker/scavver/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner, mob_types, spawn_time, faction, spawn_text, max_mobs, _range = 3)

/mob/living/simple_animal/hostile/raider/ranged/junker/scavver/death()
	RemoveComponentByType(/datum/component/spawner)
	. = ..()

/mob/living/simple_animal/hostile/raider/ranged/junker/scavver/Destroy()
	RemoveComponentByType(/datum/component/spawner)
	. = ..()

/mob/living/simple_animal/hostile/raider/ranged/junker/scavver/Aggro()
	. = ..()
	if(.)
		return
	summon_backup(10)

/mob/living/simple_animal/hostile/raider/junker/creator
	name = "Junker Field Creator"
	desc = "A Junker specialized in spitting out eyebots on the fly with any scrap they can find."
	icon_state = "junker"
	icon_living = "junker"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY
	maxHealth = 150
	health = 150
	ranged = TRUE
	retreat_distance = 6
	minimum_distance = 8
	rapid_melee = 1
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/bullet/c45/op
	projectilesound = 'sound/weapons/gunshot.ogg'
	var/list/spawned_mobs = list()
	var/max_mobs = 3
	var/mob_types = list(/mob/living/simple_animal/hostile/eyebot/reinforced)
	var/spawn_time = 15 SECONDS
	var/spawn_text = "flies from"
	footstep_type = FOOTSTEP_MOB_SHOE


/mob/living/simple_animal/hostile/raider/junker/creator/Initialize()
	. = ..()
	AddComponent(/datum/component/spawner, mob_types, spawn_time, faction, spawn_text, max_mobs, _range = 7)

/mob/living/simple_animal/hostile/raider/junker/creator/death()
	RemoveComponentByType(/datum/component/spawner)
	. = ..()

/mob/living/simple_animal/hostile/raider/junker/creator/Destroy()
	RemoveComponentByType(/datum/component/spawner)
	. = ..()

/mob/living/simple_animal/hostile/raider/junker/creator/Aggro()
	. = ..()
	if(.)
		return
	summon_backup(10)

/mob/living/simple_animal/hostile/raider/junker/boss
	name = "Junker Boss"
	desc = "A Junker boss, clad in a sentry bot helmet, wielding a deadly incinerator."
	icon_state = "junker_boss"
	icon_living = "junker_boss"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS
	maxHealth = 165
	health = 165
	ranged = TRUE
	rapid_melee = 1
	loot = list(/obj/item/gun/ballistic/rifle/mag/antimateriel/incinerator, /obj/item/clothing/head/helmet/f13/combat/mk2/raider, /obj/effect/spawner/lootdrop/f13/armor/randomraiderchest, /obj/item/clothing/under/f13/ravenharness, /obj/item/stack/f13Cash/random/high)
	retreat_distance = 4
	minimum_distance = 6
	extra_projectiles = 2
	ranged_cooldown_time = 2 SECONDS
	auto_fire_delay = GUN_AUTOFIRE_DELAY_NORMAL
	projectiletype = /obj/item/projectile/incendiary/flamethrower
	projectilesound = 'sound/weapons/flamethrower.ogg'
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/raider/junker/boss/overboss
	name = "Junker Overboss"
	desc = "The Boss of all Junker scrapheaps, clad in armour torn from a Sentry Bot, carrying a minigun torn from the wreck."
	icon_state = "junker_overboss"
	icon_living = "junker_overboss"
	icon_dead = "junker_dead"
	mob_armor = ARMOR_VALUE_ROBOT_SECURITY
	maxHealth = 200
	health = 200
	ranged = TRUE
	rapid_melee = 1
	ranged_cooldown_time = 1 SECONDS
	projectiletype = /obj/item/projectile/bullet/a556/microshrapnel
	projectilesound = 'sound/f13weapons/auto5.ogg'
	footstep_type = FOOTSTEP_MOB_SHOE
	environment_smash = ENVIRONMENT_SMASH_RWALLS
