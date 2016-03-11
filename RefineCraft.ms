console('[....] Loading RefineCraft and RC packages');

try(
  @configyml = yml_decode(comp_read('RefineCraft/config.yml'));
  ,
  sys_out('[ RC ] Failed to load config.yml!');
  );
try(
  @permissionsyml = yml_decode(comp_read('RefineCraft/permissions.yml'));
  ,
  sys_out('[ RC ] Failed to load permissions.yml!');
  );
try(
  include('RefineCraft-chat.ms');
  @RCchat = true;
  ,
  sys_out('[ RC ] Package RefineCraft-chat not installed or installed improperly. Skipping.');
  @RCchat = false;
  );
try(
  include('RefineCraft-cmds.ms');
  @RCcmds = true;
  ,
  sys_out('[ RC ] Package RefineCraft-chat not installed or installed improperly. Skipping.');
  @RCcmds = false;
  );

assign(@server_name, '§4Refine§8Craft§f');
@seconds = 1000;
@minutes = 60 * 1000;
@hours = 60 * 60 * 1000;
@AutoRestart = @configyml['RefineCraft']['AutoRestart'] * 60 * 1000;

sys_out('Automated restarts are scheduled to occur every' @AutoRestart / @minutes 'minutes');

set_interval(@AutoRestart - (15 * @minutes), closure(
 broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server in 15 minutes.')
 ))
set_interval(@AutoRestart - (10 * @minutes), closure(
 broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server in 10 minutes.')
 ))
set_interval(@AutoRestart - (5 * @minutes), closure(
 broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server in 5 minutes.')
 ))
set_interval(@AutoRestart - (2 * @minutes), closure(
 broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server in 2 minutes.')
 ))
set_interval(@AutoRestart - (1 * @minutes), closure(
 broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server in 1 minutes.')
 ))
set_interval(@AutoRestart - (5 * @seconds), closure(
 broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server now.')
 sudo(/stop)
 ))

######## ANNOUNCEMENTS ########
sys_out('[ RC ] Starting Automated announcements.');
@messages = @configyml['RefineCraft']['announcements']['messages'];
set_interval(10 * @minutes, closure(
  @messageIndex = rand(array_size(@messages['line1']));
    foreach(all_players(), @p)
      {
      #runas('~console', '/title' @p 'title' '{"text":"Get Ready", "color":"white", "bold":false, "italic":true}%nl%{"text":"Test","bold":false}');
      if(array_contains(get_scoreboards(), @p))
        {
        remove_scoreboard(@p);
        }
      create_scoreboard(@p);
      set_pscoreboard(@p, @p);
      create_objective('Announce', 'dummy', @p);
      set_objective_display('Announce', array(displayname: '   §4Refine§8Craft§f   ', slot: 'SIDEBAR'), @p);
      set_pscore('Announce', @messages['line5'][@messageIndex], 5, @p);
      set_pscore('Announce', @messages['line4'][@messageIndex], 4, @p);
      set_pscore('Announce', @messages['line3'][@messageIndex], 3, @p);
      set_pscore('Announce', @messages['line2'][@messageIndex], 2, @p);
      set_pscore('Announce', @messages['line1'][@messageIndex], 1, @p);
      }
  ));
set_interval(10 * @minutes + 10 * @seconds, closure(
  foreach(all_players(), @p)
    {
    if(array_contains(get_scoreboards(), @p))
      {
      remove_scoreboard(@p);
      }
    }
  ));

######## CREATURE SPAWN ########
store_value(mob_loop, 0);
bind(creature_spawn, null, array(type: 'CREEPER'), @event,
  @id = @event['id'];
  @loc = @event['location'];
  @type = @event['type'];
  if(get_value(mob_loop) == 0)
    {
    store_value(mob_loop, 1);
    if(rand(0,5) == 1)
      {
      spawn_entity(CREEPER, 1, @loc);
      }
    store_value(mob_loop, 0);
    }
  );

bind(creature_spawn, null, array(type: 'ENDERMAN'), @event,
 @id = @event['id'];
 @loc = @event['location'];
 @rate = 25;
 @type = @event['type'];
 if(get_value(mob_loop) == 0)
  {
  store_value(mob_loop, 1);
  if(rand(0,5) == 1)
   {
   spawn_entity('ENDERMAN', 1, @loc);
   }
  store_value(mob_loop, 0);
  }
 )

bind(creature_spawn, null, array(type: 'SKELETON'), @event,
 @id = @event['id'];
 @loc = @event['location'];
 @type = @event['type'];
 if(get_value(mob_loop) == 0)
  {
  store_value(mob_loop, 1);
  if(rand(0,5) == 1)
   {
   spawn_entity('SKELETON', 1, @loc);
   }
  store_value(mob_loop, 0);
  }
 )

bind(creature_spawn, null, array(type: 'SLIME'), @event,
 @id = @event['id'];
 @loc = @event['location'];
 @type = @event['type'];
 @MobEventFreq = 1;
 if(get_value(mob_loop) == 0)
  {
  store_value(mob_loop, 1);
  if(rand(0,5) == 1)
   {
   spawn_entity('SLIME', 1, @loc);
   }
  else if(rand(0,100) < @MobEventFreq)
   {
   lightning(@loc, true);
   play_sound(@loc, array(sound: 'SLIME_ATTACK', volume: 50, pitch: 0.5));
   @e0 = spawn_entity('SLIME', 1, @loc)[0];
   set_entity_spec(@e0, array(size: 16));
   set_mob_name(@e0, 'Queen Slime');
   }
  else if(rand(0,250) < @MobEventFreq)
   {
   lightning(@loc, true);
   play_sound(@loc, array(sound: 'SLIME_ATTACK', volume: 50, pitch: 0));
   @e0 = spawn_entity('SLIME', 1, @loc)[0];
   set_entity_spec(@e0, array(size: 24));
   set_mob_name(@e0, 'King Slime');
   }
  store_value(mob_loop, 0);
  }
 )

bind(creature_spawn, null, array(type: 'SPIDER'), @event,
 @id = @event['id'];
 @loc = @event['location'];
 @type = @event['type'];
 if(get_value(mob_loop) == 0)
  {
  store_value(mob_loop, 1);
  if(rand(0,5) == 1)
   {
   cancel();
   spawn_entity('CAVE_SPIDER', 2, @loc);
   }
  store_value(mob_loop, 0);
  }
 )

######## BOSSES ########
bind(creature_spawn, null, null, @event,
  @id = @event['id'];
  @loc = @event['location'];
  @type = @event['type'];
  @MobEventFreq = 0.1
  if(get_value(mob_loop) == 0)
    {
    store_value(mob_loop, 1);
    if(@type == 'CREEPER')
      {
      if(rand(0,100) < @MobEventFreq)
        {
        cancel();
        lightning(@loc, true);
        play_sound(@loc, array(sound: 'CREEPER_DEATH', volume: 50, pitch: 0));
        @e0 = spawn_entity('CREEPER', 1, @loc)[0];
        set_entity_spec(@e0, array(powered: true));
        set_mob_name(@e0, 'Demolisher');
        set_name_visible(@e0, true);
        @e1 = spawn_entity('ENDER_CRYSTAL', 1, @loc)[0];
        set_mob_name(@e1, 'Demolisher');
        set_name_visible(@e1, true);
        set_entity_rider(@e0, @e1);
        sys_out('A Demolisher appeared.');
        }
      }
    else if(@type == 'SPIDER')
      {
      if(rand(0,100) < @MobEventFreq)
        {
        cancel();
        lightning(@loc, true);
        play_sound(@loc, array(sound: 'SPIDER_IDLE', volume: 50, pitch: 0));
        @e0 = spawn_entity('SPIDER', 1, @loc)[0];
        for(@i = 0, @i < 49, @i++)
          {
          set_mob_name(@e0, 'Broodmother');
          set_name_visible(@e0, true);
          @e1 = spawn_entity('SPIDER', 1, @loc)[0];
          set_mob_name(@e1, 'Broodmother');
          set_name_visible(@e1, true);
          set_entity_rider(@e0, @e1);
          @e0 = @e1;
          }
          sys_out('A Broodmother appeared.');
        }
      }
    else if(@type == 'VILLAGER')
      {
      if(rand(0,100) < @MobEventFreq)
        {
        cancel();
        lightning(@loc, true);
        play_sound(@loc, array(sound: 'IRONGOLEM_DEATH', volume: 50, pitch: 0));
        @e0 = spawn_entity('AREA_EFFECT_CLOUD', 1, @loc)[0];
        set_mob_name(@e0, 'VillagerTron');
        set_name_visible(@e0, true);
        @e1 = spawn_entity('VILLAGER', 1, @loc)[0];
        set_mob_name(@e1, 'VillagerTron');
        set_name_visible(@e1, true);
        set_entity_rider(@e0, @e1);
        sys_out('A VillagerTron appeared.');
        }
      }
  else if(@type == 'ZOMBIE')
   {
   if(rand(0,100) < @MobEventFreq)
    {
    cancel();
    lightning(@loc, true);
    for(@i = 0, @i < rand(15,30), @i++)
     {
     play_sound(@loc, array(sound: 'ZOMBIE_IDLE', volume: 50, pitch: 0));
     @e0 = spawn_entity('ZOMBIE', 1, @loc)[0];
     set_mob_name(@e0, 'Zombie Horde');
     set_name_visible(@e0, true);
     }
    sys_out('A Zombie Horde appeared.');
    }
   else if(rand(0,100) < @MobEventFreq)
    {
    cancel();
    play_sound(@loc, array(sound: 'ZOMBIE_IDLE', volume: 50, pitch: 0));
    @e0 = spawn_entity('ZOMBIE', 1, @loc)[0];
    set_entity_spec(@e0, array(baby: true));
    set_mob_name(@e0, 'Mimic');
    @e1 = spawn_entity('SHULKER', 1, @loc)[0];
    #@e1 = spawn_falling_block(@loc, 146);
    set_entity_rider(@e0, @e1);
    sys_out('A Mimic appeared.');
    }
   }
  else
   {
   if(rand(0,100) < @MobEventFreq)
    {
    cancel();
    lightning(@loc, true);
    play_sound(@loc, array(sound: 'WITHER_IDLE', volume: 50, pitch: 0));
    @e0 = spawn_entity('BLAZE', 1, @loc)[0];
    set_mob_effect(@e0, 14, 1, 99999, true, false);
    set_mob_name(@e0, 'Lych');
    set_name_visible(@e0, true);
    @e1 = spawn_entity('ARMOR_STAND', 1, @loc)[0];
    set_entity_spec(@e1, array(arms: true, baseplate: false, marker: false));
    set_mob_name(@e1, 'Lych');
    set_name_visible(@e1, true);
    set_entity_rider(@e0, @e1);
    sys_out('A Lych appeared.');
    }
   }
  store_value(mob_loop, 0);
  }
  );

bind(creature_spawn, null, null, @event,
 @id = @event['id'];
 @loc = @event['location'];
 @rate = 50;
 @type = @event['type'];
 if(@type == 'WITCH')
  {
  if(rand(1,@rate) <= 10)
   {
   spawn_mob(WITCH, 1, @loc);
   }
  }
 if(@type == 'ZOMBIE')
  {
  if(rand(0,50) == 1)
   {
   spawn_mob(ZOMBIE, 1, @loc);
   }
  }
 if(@type == 'ZOMBIE')
  {
  if(rand(0,100) == 1)
   {
   #storm(true, 'world_survival_normal',1500);
   lightning(@loc, true);
   modify_event('type', GIANT);
   }
  }
 #@launch = @loc
 #@drop = @loc
 #@launch[y] = 255
 #@drop[y] = 252
 #@radius = 50
 #for(@i=0, @i < 250, ++@i)
 # {
 # @deg = rand(0,360)
 # @x = cos(@deg) * @radius * (rand(1,100) / 500)
 # @z = sin(@deg) * @radius * (rand(1,100) / 500)
 # @drop[x] = @launch[x] + @x
 # @drop[z] = @launch[z] + @z
 # @entities = spawn_entity('SMALL_FIREBALL', 1, @drop)
 # foreach(@entities, @e)
 #  {
 #  set_entity_velocity(@e, array(0, -50, 0))
 #  }
 # }
 #broadcast('§cA wild' @type 'appeared! You best run, boi!');
 )

######## DEATHPOINT ########
bind(player_death, null, null, @event,
 @player = @event['player']
 store_value(@player.'.death', ploc(@player))
 )

######## PLAYER COMMAND ########
bind(player_command, null, null, @event,
 @cmd = @event['command']
 @player = @event['player']
 @prefix = @event['prefix']
 foreach(all_players(), @other)
  {
  if(has_permission(@other, 'refinecraft.cmds.alerts.verbose'))
   {
   tmsg(@other, '§f[ §4R§8C §f] '.@player 'issued server command: '.@cmd)
   }
  else if(has_permission(@other, 'refinecraft.cmds.alerts'))
   {
   tmsg(@other, '§f[ §4R§8C §f] '.@player 'issued server command: '.@prefix)
   }
  }
 )

######## PLAYER JOIN ########
bind(player_join, null, null, @event,
 @player = @event['player']
 modify_event('join_message', null)
 store_value(@player.'.ghost', false)
 foreach(all_players(), @other)
  {
  if(has_permission(@player, 'refinecraft.ghost'))
   {
   store_value(@player.'.ghost', true)
   }
  else
   {
   store_value(@player.'.ghost', false)
   }
  @ghost = get_value(@other.'.ghost')
  if((@ghost == true)&&(!has_permission(@player, 'refinecraft.ghost.see')))
   {
   raw_set_pvanish(@other, true, @player)
   }
  else if((@ghost == false))
   {
   raw_set_pvanish(@other, false, @player)
   }
  if((has_permission(@other, 'refinecraft.ghost.alerts'))&&(get_value(@player.'.ghost') == true)&&(@other != @player))
   {
   tmsg(@other, '§f[ §4R§8C §f] §o'.@player '§rsilently joined')
   }
  if(array_contains(pgroup(@other), overseer))
   {
   set_display_name(@other, '§4Overseer §8┃ §f'.@other)
   if(length(@other) > 14)
    {
    set_list_name(@other, '§4'.substr(@other, 0, 13))
    }
   else
    {
    set_list_name(@other, '§4'.@other)
    }
   }
  else if(array_contains(pgroup(@other), administrator))
   {
   set_display_name(@other, '§3Admin §8┃ §f'.@other)
   if(length(@other) > 14)
    {
    set_list_name(@other, '§3'.substr(@other, 0, 13))
    }
   else
    {
    set_list_name(@other, '§3'.@other)
    }
   }
  else if(array_contains(pgroup(@other), moderator))
   {
   set_display_name(@other, '§2Mod §8┃ §f'.@other)
   if(length(@other) > 14)
    {
    set_list_name(@other, '§2'.substr(@other, 0, 13))
    }
   else
    {
    set_list_name(@other, '§2'.@other)
    }
   }
  else
   {
   reset_display_name(@other)
   if(length(@other) > 14)
    {
    set_list_name(@other, '§f'.substr(@other, 0, 13))
    }
   else
    {
    set_list_name(@other, '§f'.@other)
    }
   }
  if(get_value(@other.'.ghost') == true)
   {
   if(length(@other) > 14)
    {
    set_list_name(@other, '§8'.substr(@other, 0, 13))
    }
   else
    {
    set_list_name(@other, '§8'.@other)
    }
   }
  }
 if(get_value(@player.'.ghost') == true)
  {
  tmsg(@player, '§f[ §4R§8C §f] You silently joined')
  }
 else
  {
  broadcast('§e'.@player 'connected.')
  }
 tmsg(@player, '<§4Overseer §8┃ §fRefiner§f> §fWelcome back to §4Refine§8Craft§f, §o'.@player.'§r.')
 )

######## PLAYER QUIT ########
bind(player_quit, null, null, @event,
 @player = @event['player']
 modify_event('message', null)
 foreach(all_players(), @other)
  {
  @ghost = get_value(@other.'.ghost');
  if((has_permission(@other, 'refinecraft.ghost.alerts'))&&(get_value(@player.'.ghost') == true)&&(@other != @player))
   {
   tmsg(@other, '§f[§3info§f] §o'.@player '§rsilently quit')
   }
  raw_set_pvanish(@player, true, @other)
  if(array_contains(pgroup(@other), overseer))
   {
   set_display_name(@other, '§4Overseer §8┃ §f'.@other)
   if(length(@other) <= 14)
    {
    set_list_name(@other, '§4'.@other)
    }
   }
  else if(array_contains(pgroup(@other), administrator))
   {
   set_display_name(@other, '§3Admin §8┃ §f'.@other)
   if(length(@other) <= 14)
    {
    set_list_name(@other, '§3'.@other);
    }
   }
  else if(array_contains(pgroup(@other), moderator))
   {
   set_display_name(@other, '§2Mod §8┃ §f'.@other)
   if(length(@other) <= 14)
    {
    set_list_name(@other, '§2'.@other)
    }
   }
  else
   {
   reset_display_name(@other)
   if(length(@other) <= 14)
    {
    set_list_name(@other, '§f'.@other)
    }
   }
  }
 if(get_value(@player.'.ghost') == true)
  {
  tmsg(@player, '§f[ §4R§8C §f] You have silently quit')
  }
 else
  {
  broadcast('§e'.@player 'disconnected.')
  }
 store_value(@player.'.ghost', false)
 )

######## SERVER PING ########
bind(server_ping, null, null, @event,
 modify_event('motd', '\u00A78\u258E \u00A74Refine\u00A78Craft\u00A7f \u00A78\u2503 \u00A7fRefining your Experience!\n\u00A78\u258E \u00A7fNow running Minecraft 1.9! (Some Updates)')
 @ip = @event['ip'];
 @players = @event['players'];
 @maxplayers = @event['maxplayers'];
 @motd = @event['motd'];
 @list = array();
 foreach(all_players(), @other)
  {
  if(get_value(@other.'.ghost') == true)
   {
   array_remove_values(@list, @other);
   }
  else
   {
   array_push(@list, @other);
   }
  }
 modify_event('list', @list);
 if(@players < 10)
  {
  modify_event('maxplayers', 10);
  }
 else
  {
  modify_event('maxplayers', @players + 1);
  }
 sys_out('Server pinged by IP:' @event['ip']);
 )

######## SET HOME ########
bind(player_enter_bed, null, null, @event,
 @loc = @event['location']
 @player = @event['player']
 store_value(@player.'.home', @loc)
 set_compass_target(@player, @loc)
 msg('§f[ §4R§8C §f] Home set.')
 )

######## WEATHER ########
bind(weather_change, null, array(has_rain: true), @event,
 @has_rain = @event['has_rain'];
 @world = @event['world'];
 if(rand(0,10) == 1)
  {
  x_new_thread('weather', closure()
   {
   sys_out('Starting arrow rain.');
   broadcast('§cThe air smells of metal');
   sleep(5);
   foreach(all_players(), @p)
    {
    set_thunder(true, ploc(@p)['world']);
    }
   for(@i = 0, @i < 10000, @i++)
    {
    foreach(all_players(), @player)
     {
     @spawnloc = ploc(@player);
     @spawnloc[y] = 215 + rand(0,50);
     @deg = rand(0,360);
     @spawnloc[x] = ploc(@player)['x'] + 50 * cos(@deg) * (rand(0,1000)/1000);
     @spawnloc[z] = ploc(@player)['z'] + 50 * sin(@deg) * (rand(0,1000)/1000);
     x_run_on_main_thread_now(closure()
      {
      spawn_entity('ARROW', 1, @spawnloc);
      });
     }
    sleep(0.001);
    }
   foreach(all_players(), @p)
    {
    set_thunder(false, ploc(@p)['world']);
    storm(false, ploc(@p)['world']);
    }
   });
  }
 )

######## WORKBENCH ########
bind(player_interact, null, array(item: 58), @event,
 @action = @event['action'];
 @item = @event['item'];
 @player = @event['player'];
 if((@action == 'left_click_block')||(@action == 'left_click_air'))
  {
  pworkbench(@player)
  }
 )

######## WAND ########
bind(player_interact, null, array(item: 198), @event,
 @action = @event['action'];
 @item = @event['item'];
 @player = @event['player'];
 if((@action == 'left_click_block')||(@action == 'left_click_air'))
  {
  @loc = ploc(@player);
  #@cursor = ploc(@player);
  @loc['y'] = @loc['y'] + 1;
  #@cursor['x'] = 1 * cos(@loc['yaw']) * cos(@loc['pitch']);
  #@cursor['y'] = 1 * -sin(@loc['pitch']);
  #@cursor['z'] = 1 * sin(@loc['yaw']) * cos(@loc['pitch']);
  shoot_projectile(@player, 'DRAGON_FIREBALL');
  #@entities = spawn_entity('LIGHTNING', 1, @loc);
  #foreach(@entities, @e)
  # {
  # set_entity_velocity(@e, @cursor);
  # }
  }
 )

######## WORLDS ########
#@config = yml_decode(read('worlds.yml'))
#@options = @config['options'];
#@worlds = @config['worlds'];
#foreach(@config['worlds'], @world, @option)
# {
# if(@option['difficulty'] == null)
#  {
#  @option['difficulty'] = @options['default_difficulty'];
#  }
# if(@option['gamemode'] == null)
#  {
#  @option['gamemode'] = @options['default_gamemode'];
#  }
# if(@option['seed'] == null)
#  {
#  @rand = rand(-9999999999999999999, 9999999999999999999)
#  if(rand(0,1))
#   {
#   @rand = -1 * @rand;
#   }
#  @option['seed'] = @rand;
#  }
# create_world(@world, @option['type'], @option['environment'], @option['seed']);
# set_difficulty(@world, @option['difficulty']);
# foreach(@option['gamerules'], @gamerule, @value)
#  {
#  if((@gamerule != 'DOENTITYDROPS')&&(@gamerule != 'RANDOMTICKSPEED'))
#   {
#   set_gamerule(@world, @gamerule, @value);
#   }
#  }
# set_pvp(@world, @option['pvp']);
# @spawn = @option['spawn'];
# set_spawn(@world, @spawn['x'], @spawn['y'], @spawn ['z'])
# save_world(@world);
# print_out('§r[§3info§r] §r'.@world 'loaded.')
# }



console('[ ok ] RefineCraft and RC packages loaded successfully')
#broadcast('§f<§4Overseer §8┃ §fRefiner§f> §fServer code has been recompiled.')
