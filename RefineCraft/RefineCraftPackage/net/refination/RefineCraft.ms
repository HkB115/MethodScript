sys_out('[ RC ] Loading RefineCraft and RC packages');

try(
  @config = yml_decode(comp_read('config/config.yml'));
  export('net.refination.config.ConfigFile', @config);
  sys_out('[ RC ] Configuration file loaded');
  ,
  @config = 'Failure to load';
  sys_out('[ RC ] Failed to load config.yml');
  );
try(
  @permissions = yml_decode(comp_read('config/permissions.yml'));
  export('net.refination.config.PermissionsFile', @config);
  sys_out('[ RC ] Permissions file loaded');
  ,
  @permissions = 'Failure to load';
  sys_out('[ RC ] Failed to load permissions.yml');
  );

#### Component Check ####
@Components = array('Announce', 'Chat', 'Command', 'DeathLocation', 'Ghost', 'Home', 'MobEvent', 'PlayerData', 'ServerPing', 'Storm', 'Workbench');
@Commands = array('Components', 'ban', 'break', 'burn', 'crash', 'death', 'kick', 'kill', 'teleport', 'tpaccept', 'whois');
@ComponentsLoaded = array();
@CommandsLoaded = array();
for(@i = 0, @i < length(@Components), @i++)
  {
  try(
    include('components/Component'.@Components[@i].'.ms');
    array_push(@ComponentsLoaded, @Components[@i]);
    sys_out('[ RC ] Component '.@Components[@i].'.ms loaded');
    ,
    sys_out('[ RC ] Component'.@Components[@i].'.ms failed to load');
    );
  }
for(@i = 0, @i < length(@Commands), @i++)
  {
  try(
    include('commands/Command'.@Commands[@i].'.ms');
    array_push(@CommandsLoaded, @Commands[@i]);
    sys_out('[ RC ] Command '.@Commands[@i].'.ms loaded');
    ,
    sys_out('[ RC ] Command '.@Commands[@i].'.ms failed to load');
    );
  }
try(
  include('recipes/');
  ,
  sys_out('[ RC ] Failed to load recipes');
  );

assign(@server_name, '§4Refine§8Craft§f');
@seconds = 1000;
@minutes = 60 * 1000;
@hours = 60 * 60 * 1000;
@AutoRestart = @config['RefineCraft']['AutoRestart'] * 60 * 1000;

#sys_out('Automated restarts are scheduled to occur every' @AutoRestart / @minutes 'minutes');

#set_interval(@AutoRestart - (15 * @minutes), closure(
# broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server in 15 minutes.')
# ))
#set_interval(@AutoRestart - (10 * @minutes), closure(
# broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server in 10 minutes.')
# ))
#set_interval(@AutoRestart - (5 * @minutes), closure(
# broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server in 5 minutes.')
# ))
#set_interval(@AutoRestart - (2 * @minutes), closure(
# broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server in 2 minutes.')
# ))
#set_interval(@AutoRestart - (1 * @minutes), closure(
# broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server in 1 minutes.')
# ))
#set_interval(@AutoRestart - (5 * @seconds), closure(
# broadcast('§f<§4Overseer §8┃ §fRefiner§f> Restarting the server now.')
# sudo(/stop)
# ))

bind(block_place, null, array(type: 120), @event,
  @player = @event['player'];
  @bloc = ploc(@player);
  @bloc['x'] = @event['X'];
  @bloc['y'] = @event['Y'];
  @bloc['z'] = @event['Z'];
  modify_event('type', 209);
  x_new_thread('temp', closure()
    {
    broadcast('§cA black hole has been opened.');
    for(@i = 0, @i < 1000, @i++)
      {
      x_run_on_main_thread_later(closure()
        {
        try(foreach(entities_in_radius(@bloc, 50), @e)
          {
          @eloc = entity_loc(@e);
          @evel = entity_velocity(@e);
          if(@bloc['x'] < @eloc['x'])
            {
            @x = -1;
            }
          else
            {
            @x = 1;
            }
          if(@bloc['y'] < @eloc['y'])
            {
            @y = -1;
            }
          else
            {
            @y = 1;
            }
          if(@bloc['z'] < @eloc['z'])
            {
            @z = -1;
            }
          else
            {
            @z = 1;
            }
          @evel['x'] = @evel['x'] + @x * 0.1;
          @evel['y'] = @evel['y'] + @y * 0.2;
          @evel['z'] = @evel['z'] + @z * 0.1;
          set_entity_velocity(@e, @evel);
          foreach(entities_in_radius(@bloc, 1), @eclose)
            {
            damage_entity(@eclose, 100);
            }
          }, noop());
        });
      sleep(0.1);
      }
    });
  );

bind(block_place, null, array(type: 138), @event,
  @player = @event['player'];
  @bloc = ploc(@player);
  @bloc['x'] = @event['X'];
  @bloc['y'] = @event['Y'];
  @bloc['z'] = @event['Z'];
  modify_event('type', 209);
  x_new_thread('temp', closure()
    {
    broadcast('§cA white hole has been opened.');
    for(@i = 0, @i < 1000, @i++)
      {
      x_run_on_main_thread_later(closure()
        {
        try(foreach(entities_in_radius(@bloc, 50), @e)
          {
          @eloc = entity_loc(@e);
          @evel = entity_velocity(@e);
          if(@bloc['x'] < @eloc['x'])
            {
            @x = 1;
            }
          else
            {
            @x = -1;
            }
          if(@bloc['y'] < @eloc['y'])
            {
            @y = 1;
            }
          else
            {
            @y = -1;
            }
          if(@bloc['z'] < @eloc['z'])
            {
            @z = 1;
            }
          else
            {
            @z = -1;
            }
          @evel['x'] = @evel['x'] + @x * 0.1;
          @evel['y'] = @evel['y'] + @y * 0.2;
          @evel['z'] = @evel['z'] + @z * 0.1;
          set_entity_velocity(@e, @evel);
          foreach(entities_in_radius(@bloc, 1), @eclose)
            {
            damage_entity(@eclose, 100);
            }
          }, noop());
        });
      sleep(0.1);
      }
    });
  );

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



sys_out('[ RC ] RefineCraft and RC packages loaded successfully');
