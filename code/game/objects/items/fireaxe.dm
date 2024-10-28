/*
 * Fireaxe
 */
/obj/item/fireaxe  // DEM AXES MAN, marker -Agouri
	icon = 'icons/obj/weapons/fireaxe.dmi'
	icon_state = "fireaxe0"
	base_icon_state = "fireaxe"
	lefthand_file = 'icons/mob/inhands/weapons/axes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/axes_righthand.dmi'
	name = "fire axe"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"
	force = 5
	throwforce = 15
	demolition_mod = 1.25
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("attacks", "chops", "cleaves", "tears", "lacerates", "cuts")
	attack_verb_simple = list("attack", "chop", "cleave", "tear", "lacerate", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	armor_type = /datum/armor/item_fireaxe
	resistance_flags = FIRE_PROOF
	wound_bonus = -15
	bare_wound_bonus = 20
	/// How much damage to do unwielded
	var/force_unwielded = 5
	/// How much damage to do wielded
	var/force_wielded = 24

/datum/armor/item_fireaxe
	fire = 100
	acid = 30

/obj/item/fireaxe/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
		speed = 10 SECONDS, \
		effectiveness = 80, \
		bonus_modifier = 0 , \
		butcher_sound = hitsound, \
	)
	//axes are not known for being precision butchering tools
	AddComponent(/datum/component/two_handed, force_unwielded=force_unwielded, force_wielded=force_wielded, icon_wielded="[base_icon_state]1")

/obj/item/fireaxe/update_icon_state()
	icon_state = "[base_icon_state]0"
	return ..()

/obj/item/fireaxe/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] axes [user.p_them()]self from head to toe! It looks like [user.p_theyre()] trying to commit suicide!"))
	return BRUTELOSS

/obj/item/fireaxe/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(HAS_TRAIT(src, TRAIT_WIELDED)) //destroys windows and grilles in one hit
		if(istype(A, /obj/structure/window) || istype(A, /obj/structure/grille))
			if(!(A.resistance_flags & INDESTRUCTIBLE))
				var/obj/structure/W = A
				W.atom_destruction("fireaxe")

/*
 * Bone Axe
 */
/obj/item/fireaxe/boneaxe  // Blatant imitation of the fireaxe, but made out of bone.
	icon_state = "bone_axe0"
	base_icon_state = "bone_axe"
	name = "bone axe"
	desc = "A large, vicious axe crafted out of several sharpened bone plates and crudely tied together. Made of monsters, by killing monsters, for killing monsters."
	force_unwielded = 5
	force_wielded = 23

/*
 * Metal Hydrogen Axe
 */
/obj/item/fireaxe/metal_h2_axe
	icon_state = "metalh2_axe0"
	base_icon_state = "metalh2_axe"
	name = "metallic hydrogen axe"
	desc = "A lightweight crowbar with an extreme sharp fire axe head attached. It trades it's hefty as a weapon by making it easier to carry around when holstered to suits without having to sacrifice your backpack."
	force_unwielded = 5
	force_wielded = 15
	demolition_mod = 2
	tool_behaviour = TOOL_CROWBAR
	toolspeed = 1
	usesound = 'sound/items/crowbar.ogg'

  /*
   * Makeshift Axe from glass shards and iron rod
   */
/obj/item/fireaxe/makeshift_glass_axe  // Imitation of the fireaxe, but with glass shards and iron rod.
  	icon_state = "makeshift_glass_axe0"
  	base_icon_state = "makeshift_glass_axe"
  	name = "Hache de fortune"
  	desc = "Une hache grossièrement assemblée de bouts de verres et d'une barre de métal"
  	slot_flags = ITEM_SLOT_BACK
  	force_unwielded = 4
  	force_wielded = 8

/obj/item/fireaxe/makeshift_glass_axe/afterattack(atom/A, mob/user, proximity)
  	. = ..()
  	if (!proximity)
  	  	return
  	uses_left -= 1
  	if (uses_left == 14)
  	  	user.visible_message("La [name] de [user] commence à se fissurer")
	if (uses_left == 5)
  	  	user.visible_message("La [name] de [user] commence à se désassembler... il ne reste plus que quelques coups.")
	if (uses_left == 0)
  	  	user.visible_message("La [name] de [user] se brise dans ses mains !")
		qdel(src)
