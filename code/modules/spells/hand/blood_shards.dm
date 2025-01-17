/datum/spell/hand/charges/blood_shard
	name = "Blood Shards"
	desc = "Invoke a corrupted projectile forward that causes an enemy's blood to fly out in painful shards. Be sure to upgrade it, as it is free."

	spell_flags = 0
	charge_max = 600
	invocation = "opens their hand, which bursts into vicious red light."
	invocation_type = SPI_EMOTE
	level_max = list(SP_TOTAL = 2, SP_SPEED = 2, SP_POWER = 0)
	range = 7
	max_casts = 2
	compatible_targets = list(/atom)
	icon_state = "wiz_bshard"

/datum/spell/hand/charges/blood_shard/cast_hand(atom/A,mob/user)
	var/obj/item/projectile/blood_shard/B = new(get_turf(user))
	B.firer = user
	B.launch(A, BP_CHEST)
	user.visible_message("<span class='danger'>\The [user] shoots out a deep red shard from their hand!</span>")
	return ..()

/obj/item/projectile/blood_shard
	name = "bloodshard"
	damage = 15
	check_armour = "melee"
	icon_state = "blood"
	damage_type = BRUTE

/obj/item/projectile/blood_shard/on_hit(atom/movable/target, blocked = 0)
	if(..())
		if(istype(target, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = target
			H.vessel.remove_reagent(/datum/reagent/blood, 30)
			H.visible_message("<span class='danger'>Tiny red shards burst from \the [H]'s skin!</span>")
			fragmentate(get_turf(src), 30, 5, list(/obj/item/projectile/bullet/pellet/blood))

/obj/item/projectile/bullet/pellet/blood
	name = "blood fragment"
	damage = 4
