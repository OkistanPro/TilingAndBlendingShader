// uv offsets
#define NUM_NORMAL_BLOCKS 242
#define NUM_4BRICKS_BLOCKS 11
#define NUM_2BRICKS_BLOCKS 19
#define BLR_BLOCKS 44
#define BORDER_LESS_BLOCKS 23
#define ROTATE_BLOCKS 104

// Define UV offsets for each block category
const vec2 normalBlockOffsets[NUM_NORMAL_BLOCKS] = vec2[NUM_NORMAL_BLOCKS](
    vec2(48.0, 80.0), //acacia_log
    vec2(80.0, 80.0), //acacia_planks
    vec2(48.0, 96.0), //amethyst_block
    vec2(80.0, 96.0), //ancient_debris_side
    vec2(112.0, 96.0), //andesite
    vec2(64.0, 112.0), //azalea_leaves
    vec2(112.0, 112.0), //azalea_top
    vec2(160.0, 32.0), //barrel_side
    vec2(160.0, 80.0), //basalt_side
    vec2(160.0, 96.0), //basalt_top
    vec2(176.0, 0.0), //bedrock
    vec2(208.0, 112.0), //birch_leaves
    vec2(224.0, 0.0), //birch_log
    vec2(224.0, 112.0), //black_concrete
    vec2(240.0, 0.0), //black_concrete_powder
    vec2(240.0, 80.0), //black_terracotta
    vec2(240.0, 96.0), //black_wool
    vec2(240.0, 112.0), //blackstone
    vec2(112.0, 128.0), //blue_concrete
    vec2(128.0, 128.0), //blue_concrete_powder
    vec2(160.0, 128.0), //blue_ice
    vec2(240.0, 128.0), //blue_terracotta
    vec2(0.0, 144.0), //blue_wool
    vec2(16.0, 144.0), //bone_block_side
    vec2(80.0, 144.0), //brain_coral_block
    vec2(128.0, 144.0), //brewing_stand_base
    vec2(192.0, 144.0), //brown_concrete
    vec2(208.0, 144.0), //brown_concrete_powder
    vec2(64.0, 160.0), //brown_terracotta
    vec2(80.0, 160.0), //brown_wool
    vec2(112.0, 160.0), //bubble_coral_block
    vec2(48.0, 176.0), //calcite
    vec2(64.0, 208.0), //cherry_leaves
    vec2(80.0, 208.0), //cherry_log
    vec2(112.0, 208.0), //cherry_planks
    vec2(240.0, 224.0), //chorus_plant
    vec2(0.0, 240.0), //clay
    vec2(32.0, 240.0), //coal_block
    vec2(96.0, 240.0), //cobblestone
    vec2(288.0, 128.0), //creaking_heart
    vec2(288.0, 144.0), //creaking_heart_awake
    vec2(288.0, 160.0), //creaking_heart_dormant
    vec2(304.0, 16.0), //crimson_nylium
    vec2(304.0, 32.0), //crimson_nylium_side
    vec2(304.0, 48.0), //crimson_planks
    vec2(304.0, 96.0), //crimson_stem
    vec2(304.0, 144.0), //crying_obsidian
    vec2(304.0, 240.0), //cyan_concrete
    vec2(320.0, 0.0), //cyan_concrete_powder
    vec2(320.0, 80.0), //cyan_terracotta
    vec2(320.0, 96.0), //cyan_wool
    vec2(320.0, 176.0), //dark_oak_leaves
    vec2(320.0, 192.0), //dark_oak_log
    vec2(320.0, 224.0), //dark_oak_planks
    vec2(336.0, 96.0), //dead_brain_coral_block
    vec2(336.0, 144.0), //dead_bubble_coral_block
    vec2(336.0, 208.0), //dead_fire_coral_block
    vec2(352.0, 0.0), //dead_horn_coral_block
    vec2(352.0, 48.0), //dead_tube_coral_block
    vec2(352.0, 112.0), //deepslate
    vec2(368.0, 16.0), //deepslate_tiles
    vec2(368.0, 32.0), //deepslate_top
    vec2(384.0, 16.0), //diorite
    vec2(384.0, 32.0), //dirt
    vec2(384.0, 64.0), //dirt_path_top
    vec2(384.0, 112.0), //dragon_egg
    vec2(384.0, 176.0), //dripstone_block
    vec2(400.0, 0.0), //enchanting_table_bottom
    vec2(400.0, 112.0), //end_stone
    vec2(416.0, 64.0), //farmland
    vec2(416.0, 80.0), //farmland_moist
    vec2(416.0, 160.0), //fire_coral_block
    vec2(432.0, 32.0), //flowering_azalea_leaves
    vec2(432.0, 64.0), //flowering_azalea_top
    vec2(432.0, 224.0), //gilded_blackstone
    vec2(448.0, 32.0), //glow_lichen
    vec2(448.0, 48.0), //glowstone
    vec2(448.0, 96.0), //granite
    vec2(448.0, 112.0), //grass_block_side
    vec2(448.0, 128.0), //grass_block_side_overlay
    vec2(448.0, 144.0), //grass_block_snow
    vec2(448.0, 160.0), //grass_block_top
    vec2(448.0, 176.0), //gravel
    vec2(448.0, 224.0), //gray_concrete
    vec2(448.0, 240.0), //gray_concrete_powder
    vec2(464.0, 64.0), //gray_terracotta
    vec2(464.0, 80.0), //gray_wool
    vec2(464.0, 128.0), //green_concrete
    vec2(464.0, 144.0), //green_concrete_powder
    vec2(464.0, 224.0), //green_terracotta
    vec2(464.0, 240.0), //green_wool
    vec2(480.0, 64.0), //hay_block_side
    vec2(480.0, 80.0), //hay_block_top
    vec2(480.0, 112.0), //honey_block_bottom
    vec2(480.0, 128.0), //honey_block_side
    vec2(480.0, 144.0), //honey_block_top
    vec2(480.0, 160.0), //honeycomb_block
    vec2(480.0, 192.0), //hopper_outside
    vec2(480.0, 240.0), //horn_coral_block
    vec2(496.0, 16.0), //ice
    vec2(32.0, 256.0), //jungle_leaves
    vec2(48.0, 256.0), //jungle_log
    vec2(80.0, 256.0), //jungle_planks
    vec2(272.0, 256.0), //lava_still
    vec2(288.0, 256.0), //leaf_litter
    vec2(416.0, 256.0), //light_blue_concrete
    vec2(432.0, 256.0), //light_blue_concrete_powder
    vec2(0.0, 272.0), //light_blue_terracotta
    vec2(16.0, 272.0), //light_blue_wool
    vec2(64.0, 272.0), //light_gray_concrete
    vec2(80.0, 272.0), //light_gray_concrete_powder
    vec2(176.0, 272.0), //light_gray_wool
    vec2(320.0, 272.0), //lime_concrete
    vec2(336.0, 272.0), //lime_concrete_powder
    vec2(416.0, 272.0), //lime_terracotta
    vec2(432.0, 272.0), //lime_wool
    vec2(64.0, 288.0), //magenta_concrete
    vec2(80.0, 288.0), //magenta_concrete_powder
    vec2(160.0, 288.0), //magenta_terracotta
    vec2(176.0, 288.0), //magenta_wool
    vec2(192.0, 288.0), //magma
    vec2(240.0, 288.0), //mangrove_leaves
    vec2(256.0, 288.0), //mangrove_log
    vec2(288.0, 288.0), //mangrove_planks
    vec2(336.0, 288.0), //mangrove_roots_side
    vec2(352.0, 288.0), //mangrove_roots_top
    vec2(400.0, 288.0), //melon_side
    vec2(448.0, 288.0), //moss_block
    vec2(464.0, 288.0), //mossy_cobblestone
    vec2(496.0, 288.0), //mud
    vec2(16.0, 304.0), //muddy_mangrove_roots_side
    vec2(32.0, 304.0), //muddy_mangrove_roots_top
    vec2(48.0, 304.0), //mushroom_block_inside
    vec2(64.0, 304.0), //mushroom_stem
    vec2(80.0, 304.0), //mycelium_side
    vec2(96.0, 304.0), //mycelium_top
    vec2(192.0, 304.0), //nether_wart_block
    vec2(272.0, 304.0), //netherrack
    vec2(336.0, 304.0), //oak_leaves
    vec2(352.0, 304.0), //oak_log
    vec2(384.0, 304.0), //oak_planks
    vec2(0.0, 320.0), //obsidian
    vec2(112.0, 320.0), //orange_concrete
    vec2(128.0, 320.0), //orange_concrete_powder
    vec2(208.0, 320.0), //orange_terracotta
    vec2(240.0, 320.0), //orange_wool
    vec2(0.0, 336.0), //pale_moss_block
    vec2(16.0, 336.0), //pale_moss_carpet
    vec2(96.0, 336.0), //pale_oak_leaves
    vec2(112.0, 336.0), //pale_oak_log
    vec2(144.0, 336.0), //pale_oak_planks
    vec2(288.0, 336.0), //pink_concrete
    vec2(304.0, 336.0), //pink_concrete_powder
    vec2(416.0, 336.0), //pink_terracotta
    vec2(448.0, 336.0), //pink_wool
    vec2(176.0, 352.0), //podzol_side
    vec2(192.0, 352.0), //podzol_top
    vec2(176.0, 368.0), //powder_snow
    vec2(224.0, 368.0), //prismarine
    vec2(256.0, 368.0), //pumpkin_side
    vec2(336.0, 368.0), //purple_concrete
    vec2(352.0, 368.0), //purple_concrete_powder
    vec2(432.0, 368.0), //purple_terracotta
    vec2(448.0, 368.0), //purple_wool
    vec2(0.0, 384.0), //quartz_block_bottom
    vec2(64.0, 384.0), //quartz_pillar
    vec2(128.0, 384.0), //raw_copper_block
    vec2(144.0, 384.0), //raw_gold_block
    vec2(160.0, 384.0), //raw_iron_block
    vec2(208.0, 384.0), //red_concrete
    vec2(224.0, 384.0), //red_concrete_powder
    vec2(272.0, 384.0), //red_mushroom_block
    vec2(304.0, 384.0), //red_sand
    vec2(320.0, 384.0), //red_sandstone
    vec2(336.0, 384.0), //red_sandstone_bottom
    vec2(352.0, 384.0), //red_sandstone_top
    vec2(416.0, 384.0), //red_terracotta
    vec2(448.0, 384.0), //red_wool
    vec2(256.0, 400.0), //resin_block
    vec2(288.0, 400.0), //resin_clump
    vec2(304.0, 400.0), //respawn_anchor_bottom
    vec2(432.0, 400.0), //rooted_dirt
    vec2(480.0, 400.0), //sand
    vec2(496.0, 400.0), //sandstone
    vec2(0.0, 416.0), //sandstone_bottom
    vec2(16.0, 416.0), //sandstone_top
    vec2(80.0, 416.0), //sculk
    vec2(144.0, 416.0), //sculk_catalyst_top
    vec2(160.0, 416.0), //sculk_catalyst_top_bloom
    vec2(176.0, 416.0), //sculk_sensor_bottom
    vec2(240.0, 416.0), //sculk_sensor_top
    vec2(256.0, 416.0), //sculk_shrieker_bottom
    vec2(336.0, 416.0), //sculk_vein
    vec2(464.0, 416.0), //slime_block
    vec2(192.0, 432.0), //smooth_basalt
    vec2(464.0, 432.0), //sniffer_egg_very_cracked_north
    vec2(112.0, 448.0), //soul_sand
    vec2(176.0, 448.0), //sponge
    vec2(256.0, 448.0), //spruce_leaves
    vec2(272.0, 448.0), //spruce_log
    vec2(304.0, 448.0), //spruce_planks
    vec2(352.0, 448.0), //stone
    vec2(448.0, 448.0), //stripped_acacia_log
    vec2(0.0, 464.0), //stripped_birch_log
    vec2(32.0, 464.0), //stripped_cherry_log
    vec2(64.0, 464.0), //stripped_crimson_stem
    vec2(96.0, 464.0), //stripped_dark_oak_log
    vec2(128.0, 464.0), //stripped_jungle_log
    vec2(160.0, 464.0), //stripped_mangrove_log
    vec2(192.0, 464.0), //stripped_oak_log
    vec2(224.0, 464.0), //stripped_pale_oak_log
    vec2(256.0, 464.0), //stripped_spruce_log
    vec2(288.0, 464.0), //stripped_warped_stem
    vec2(480.0, 464.0), //suspicious_gravel_0
    vec2(496.0, 464.0), //suspicious_gravel_1
    vec2(0.0, 480.0), //suspicious_gravel_2
    vec2(16.0, 480.0), //suspicious_gravel_3
    vec2(32.0, 480.0), //suspicious_sand_0
    vec2(48.0, 480.0), //suspicious_sand_1
    vec2(64.0, 480.0), //suspicious_sand_2
    vec2(80.0, 480.0), //suspicious_sand_3
    vec2(272.0, 480.0), //terracotta
    vec2(208.0, 496.0), //tube_coral_block
    vec2(240.0, 496.0), //tuff
    vec2(512.0, 192.0), //warped_nylium
    vec2(512.0, 208.0), //warped_nylium_side
    vec2(512.0, 224.0), //warped_planks
    vec2(512.0, 272.0), //warped_stem
    vec2(512.0, 320.0), //warped_wart_block
    vec2(528.0, 64.0), //wet_sponge
    vec2(528.0, 240.0), //white_concrete
    vec2(528.0, 256.0), //white_concrete_powder
    vec2(528.0, 336.0), //white_terracotta
    vec2(528.0, 368.0), //white_wool
    vec2(528.0, 464.0), //yellow_concrete
    vec2(528.0, 480.0), //yellow_concrete_powder
    vec2(544.0, 48.0), //yellow_terracotta
    vec2(544.0, 64.0), //yellow_wool
    vec2(976.0, 0.0), //sandstonecut_red_sandstone1
    vec2(976.0, 64.0), //sandstonecut_sandstone1
    vec2(976.0, 112.0), //sandstonered_sandstone
    vec2(976.0, 128.0) //sandstonesandstone
);

const vec2 bricks4BlockOffsets[NUM_4BRICKS_BLOCKS] = vec2[NUM_4BRICKS_BLOCKS](
    vec2(128.0, 16.0), //bamboo_block
    vec2(144.0, 48.0), //bamboo_planks
    vec2(176.0, 64.0), //bee_nest_side
    vec2(144.0, 144.0), //bricks
    vec2(272.0, 64.0), //cracked_nether_bricks
    vec2(336.0, 16.0), //dark_prismarine
    vec2(112.0, 304.0), //nether_bricks
    vec2(288.0, 384.0), //red_nether_bricks
    vec2(272.0, 400.0), //resin_bricks
    vec2(480.0, 448.0), //stripped_bamboo_block
    vec2(400.0, 464.0) //sugar_cane
);

const vec2 bricks2BlockOffsets[NUM_2BRICKS_BLOCKS] = vec2[NUM_2BRICKS_BLOCKS](
    vec2(48.0, 144.0), //bookshelf
    vec2(176.0, 208.0), //chiseled_bookshelf_empty
    vec2(192.0, 208.0), //chiseled_bookshelf_occupied
    vec2(272.0, 32.0), //cracked_deepslate_bricks
    vec2(272.0, 48.0), //cracked_deepslate_tiles
    vec2(272.0, 80.0), //cracked_polished_blackstone_bricks
    vec2(272.0, 96.0), //cracked_stone_bricks
    vec2(352.0, 128.0), //deepslate_bricks
    vec2(400.0, 128.0), //end_stone_bricks
    vec2(480.0, 288.0), //mossy_stone_bricks
    vec2(0.0, 304.0), //mud_bricks
    vec2(432.0, 352.0), //polished_blackstone_bricks
    vec2(48.0, 384.0), //quartz_bricks
    vec2(368.0, 448.0), //stone_bricks
    vec2(256.0, 496.0), //tuff_bricks
    vec2(544.0, 80.0), //bookshelf0
    vec2(544.0, 96.0), //bookshelf1
    vec2(544.0, 112.0), //bookshelf2
    vec2(544.0, 128.0) //bookshelf3
);

const vec2 borderLessRotateBlockOffsets[BLR_BLOCKS] = vec2[BLR_BLOCKS](
    vec2(240.0, 208.0), //chiseled_copper
    vec2(256.0, 112.0), //copper_block
    vec2(256.0, 128.0), //copper_bulb
    vec2(256.0, 144.0), //copper_bulb_lit
    vec2(256.0, 160.0), //copper_bulb_lit_powered
    vec2(256.0, 176.0), //copper_bulb_powered
    vec2(256.0, 224.0), //copper_grate
    vec2(272.0, 0.0), //copper_trapdoor
    vec2(368.0, 240.0), //diamond_block
    vec2(400.0, 144.0), //exposed_chiseled_copper
    vec2(400.0, 160.0), //exposed_copper
    vec2(400.0, 176.0), //exposed_copper_bulb
    vec2(400.0, 192.0), //exposed_copper_bulb_lit
    vec2(400.0, 208.0), //exposed_copper_bulb_lit_powered
    vec2(400.0, 224.0), //exposed_copper_bulb_powered
    vec2(416.0, 16.0), //exposed_copper_grate
    vec2(416.0, 32.0), //exposed_copper_trapdoor
    vec2(448.0, 64.0), //gold_block
    vec2(192.0, 256.0), //lapis_block
    vec2(272.0, 320.0), //oxidized_chiseled_copper
    vec2(288.0, 320.0), //oxidized_copper
    vec2(304.0, 320.0), //oxidized_copper_bulb
    vec2(320.0, 320.0), //oxidized_copper_bulb_lit
    vec2(336.0, 320.0), //oxidized_copper_bulb_lit_powered
    vec2(352.0, 320.0), //oxidized_copper_bulb_powered
    vec2(400.0, 320.0), //oxidized_copper_grate
    vec2(416.0, 320.0), //oxidized_copper_trapdoor
    vec2(368.0, 352.0), //polished_andesite
    vec2(416.0, 352.0), //polished_blackstone
    vec2(448.0, 352.0), //polished_deepslate
    vec2(464.0, 352.0), //polished_diorite
    vec2(480.0, 352.0), //polished_granite
    vec2(496.0, 352.0), //polished_tuff
    vec2(16.0, 384.0), //quartz_block_side
    vec2(32.0, 384.0), //quartz_block_top
    vec2(432.0, 416.0), //shroomlight
    vec2(512.0, 368.0), //weathered_chiseled_copper
    vec2(512.0, 384.0), //weathered_copper
    vec2(512.0, 400.0), //weathered_copper_bulb
    vec2(512.0, 416.0), //weathered_copper_bulb_lit
    vec2(512.0, 432.0), //weathered_copper_bulb_lit_powered
    vec2(512.0, 448.0), //weathered_copper_bulb_powered
    vec2(512.0, 496.0), //weathered_copper_grate
    vec2(528.0, 0.0) //weathered_copper_trapdoor
);

const vec2 borderLessBlockOffsets[BORDER_LESS_BLOCKS] = vec2[BORDER_LESS_BLOCKS](
    vec2(48.0, 240.0), //coal_ore
    vec2(256.0, 240.0), //copper_ore
    vec2(352.0, 144.0), //deepslate_coal_ore
    vec2(352.0, 160.0), //deepslate_copper_ore
    vec2(352.0, 176.0), //deepslate_diamond_ore
    vec2(352.0, 192.0), //deepslate_emerald_ore
    vec2(352.0, 208.0), //deepslate_gold_ore
    vec2(352.0, 224.0), //deepslate_iron_ore
    vec2(352.0, 240.0), //deepslate_lapis_ore
    vec2(368.0, 0.0), //deepslate_redstone_ore
    vec2(384.0, 0.0), //diamond_ore
    vec2(384.0, 240.0), //emerald_ore
    vec2(448.0, 80.0), //gold_ore
    vec2(496.0, 96.0), //iron_ore
    vec2(208.0, 256.0), //lapis_ore
    vec2(128.0, 304.0), //nether_gold_ore
    vec2(16.0, 320.0), //ochre_froglight_side
    vec2(32.0, 320.0), //ochre_froglight_top
    vec2(192.0, 336.0), //pearlescent_froglight_side
    vec2(208.0, 336.0), //pearlescent_froglight_top
    vec2(64.0, 400.0), //redstone_ore
    vec2(512.0, 96.0), //verdant_froglight_side
    vec2(512.0, 112.0) //verdant_froglight_top
);

const vec2 rotateBlockOffsets[ROTATE_BLOCKS] = vec2[ROTATE_BLOCKS](
    vec2(64.0, 80.0), //acacia_log_top
    vec2(96.0, 96.0), //ancient_debris_top
    vec2(128.0, 32.0), //bamboo_block_top
    vec2(144.0, 32.0), //bamboo_mosaic
    vec2(160.0, 0.0), //bamboo_trapdoor
    vec2(160.0, 48.0), //barrel_top
    vec2(160.0, 64.0), //barrel_top_open
    vec2(176.0, 16.0), //bee_nest_bottom
    vec2(176.0, 80.0), //bee_nest_top
    vec2(224.0, 16.0), //birch_log_top
    vec2(224.0, 32.0), //birch_planks
    vec2(64.0, 128.0), //blast_furnace_top
    vec2(32.0, 144.0), //bone_block_top
    vec2(176.0, 160.0), //cactus_bottom
    vec2(224.0, 160.0), //cactus_top
    vec2(240.0, 160.0), //cake_bottom
    vec2(32.0, 176.0), //cake_top
    vec2(80.0, 192.0), //cauldron_bottom
    vec2(96.0, 192.0), //cauldron_inner
    vec2(128.0, 192.0), //cauldron_top
    vec2(96.0, 208.0), //cherry_log_top
    vec2(224.0, 208.0), //chiseled_bookshelf_top
    vec2(208.0, 224.0), //chorus_flower
    vec2(224.0, 224.0), //chorus_flower_dead
    vec2(256.0, 32.0), //composter_compost
    vec2(256.0, 48.0), //composter_ready
    vec2(256.0, 80.0), //composter_top
    vec2(272.0, 112.0), //crafter_bottom
    vec2(288.0, 112.0), //crafting_table_top
    vec2(288.0, 176.0), //creaking_heart_top
    vec2(288.0, 192.0), //creaking_heart_top_awake
    vec2(288.0, 208.0), //creaking_heart_top_dormant
    vec2(304.0, 112.0), //crimson_stem_top
    vec2(320.0, 208.0), //dark_oak_log_top
    vec2(336.0, 32.0), //daylight_detector_inverted_top
    vec2(336.0, 48.0), //daylight_detector_side
    vec2(336.0, 64.0), //daylight_detector_top
    vec2(384.0, 96.0), //dispenser_front_vertical
    vec2(384.0, 208.0), //dropper_front_vertical
    vec2(384.0, 224.0), //emerald_block
    vec2(432.0, 208.0), //furnace_top
    vec2(480.0, 176.0), //hopper_inside
    vec2(480.0, 208.0), //hopper_top
    vec2(496.0, 112.0), //iron_trapdoor
    vec2(496.0, 224.0), //jukebox_side
    vec2(448.0, 272.0), //lodestone_side
    vec2(464.0, 272.0), //lodestone_top
    vec2(272.0, 288.0), //mangrove_log_top
    vec2(368.0, 288.0), //mangrove_trapdoor
    vec2(432.0, 288.0), //melon_top
    vec2(256.0, 304.0), //netherite_block
    vec2(288.0, 304.0), //note_block
    vec2(368.0, 304.0), //oak_log_top
    vec2(416.0, 304.0), //oak_trapdoor
    vec2(128.0, 336.0), //pale_oak_log_top
    vec2(464.0, 336.0), //piston_bottom
    vec2(480.0, 336.0), //piston_inner
    vec2(400.0, 352.0), //polished_basalt_top
    vec2(288.0, 368.0), //pumpkin_top
    vec2(496.0, 368.0), //purpur_pillar_top
    vec2(80.0, 384.0), //quartz_pillar_top
    vec2(464.0, 384.0), //redstone_block
    vec2(32.0, 400.0), //redstone_lamp
    vec2(48.0, 400.0), //redstone_lamp_on
    vec2(112.0, 400.0), //reinforced_deepslate_bottom
    vec2(144.0, 400.0), //reinforced_deepslate_top
    vec2(32.0, 416.0), //scaffolding_bottom
    vec2(64.0, 416.0), //scaffolding_top
    vec2(96.0, 416.0), //sculk_catalyst_bottom
    vec2(48.0, 432.0), //smithing_table_bottom
    vec2(96.0, 432.0), //smithing_table_top
    vec2(112.0, 432.0), //smoker_bottom
    vec2(176.0, 432.0), //smoker_top
    vec2(288.0, 448.0), //spruce_log_top
    vec2(464.0, 448.0), //stripped_acacia_log_top
    vec2(496.0, 448.0), //stripped_bamboo_block_top
    vec2(16.0, 464.0), //stripped_birch_log_top
    vec2(48.0, 464.0), //stripped_cherry_log_top
    vec2(80.0, 464.0), //stripped_crimson_stem_top
    vec2(112.0, 464.0), //stripped_dark_oak_log_top
    vec2(144.0, 464.0), //stripped_jungle_log_top
    vec2(176.0, 464.0), //stripped_mangrove_log_top
    vec2(208.0, 464.0), //stripped_oak_log_top
    vec2(240.0, 464.0), //stripped_pale_oak_log_top
    vec2(272.0, 464.0), //stripped_spruce_log_top
    vec2(304.0, 464.0), //stripped_warped_stem_top
    vec2(240.0, 480.0), //target_side
    vec2(256.0, 480.0), //target_top
    vec2(384.0, 480.0), //tnt_bottom
    vec2(416.0, 480.0), //tnt_top
    vec2(496.0, 480.0), //trial_spawner_bottom
    vec2(64.0, 496.0), //trial_spawner_top_active
    vec2(80.0, 496.0), //trial_spawner_top_active_ominous
    vec2(96.0, 496.0), //trial_spawner_top_ejecting_reward
    vec2(112.0, 496.0), //trial_spawner_top_ejecting_reward_ominous
    vec2(128.0, 496.0), //trial_spawner_top_inactive
    vec2(144.0, 496.0), //trial_spawner_top_inactive_ominous
    vec2(352.0, 496.0), //vault_bottom
    vec2(368.0, 496.0), //vault_bottom_ominous
    vec2(512.0, 32.0), //vault_top
    vec2(512.0, 48.0), //vault_top_ejecting
    vec2(512.0, 64.0), //vault_top_ejecting_ominous
    vec2(512.0, 80.0), //vault_top_ominous
    vec2(512.0, 288.0) //warped_stem_top
);

vec2 minUVNormal(int blockIndex) {
    return normalBlockOffsets[blockIndex] / atlasSize;
}

vec2 maxUVNormal(int blockIndex) {
    return (normalBlockOffsets[blockIndex] + vec2(16.0, 16.0)) / atlasSize;
}

vec2 minUV4Bricks(int blockIndex) {
    return bricks4BlockOffsets[blockIndex] / atlasSize;
}

vec2 maxUV4Bricks(int blockIndex) {
    return (bricks4BlockOffsets[blockIndex] + vec2(16.0, 16.0)) / atlasSize;
}

vec2 minUV2Bricks(int blockIndex) {
    return bricks2BlockOffsets[blockIndex] / atlasSize;
}

vec2 maxUV2Bricks(int blockIndex) {
    return (bricks2BlockOffsets[blockIndex] + vec2(16.0, 16.0)) / atlasSize;
}

vec2 minUVBLR(int blockIndex) {
    return (borderLessRotateBlockOffsets[blockIndex]+ vec2(1.0, 1.0)) / atlasSize;
}

vec2 maxUVBLR(int blockIndex) {
    return (borderLessRotateBlockOffsets[blockIndex] + vec2(15.0, 15.0)) /atlasSize;
}

vec2 minUVBorderLess(int blockIndex) {
    return (borderLessBlockOffsets[blockIndex]+ vec2(1.0, 1.0)) / atlasSize;
}

vec2 maxUVBorderLess(int blockIndex) {
    return (borderLessBlockOffsets[blockIndex] + vec2(15.0, 15.0)) / atlasSize;
}

vec2 minUVRotate(int blockIndex){
    return (rotateBlockOffsets[blockIndex]) / atlasSize;
}

vec2 maxUVRotate(int blockIndex){
    return (rotateBlockOffsets[blockIndex] + vec2(16.0, 16.0)) / atlasSize; 
}

vec2 minUVdirtpath() {
    return vec2(384.0, 49.0) / atlasSize;
}

vec2 maxUVdirtpath() {
    return (vec2(384.0, 49.0) + vec2(16.0, 16.0)) / atlasSize;
}
