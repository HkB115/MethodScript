

######## BURN ########
register_command('burn', array(
 'description': 'Burns the player to death.',
 'usage': '§f[ §4R§8C §f] Usage: /burn <player>',
 'permission': 'refinecraft.burn',
 'noPermMsg': '§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f',
 'tabcompleter': closure(@alias, @sender, @arg)
  {
  if(array_size(@arg) == 0)
   {
   return(all_players());
   }
  @search = @arg[array_size(@arg) - 1];
  return(array_filter(all_players(), closure(@index, @player)
   {
   return(equals_ic(@search, substr(@player, 0, length(@search))));
   }));
  },
 'aliases': array('burnalias'),
 'executor': closure(@alias, @sender, @arg)
  {
  if(array_size(@arg) == 1)
   {
   if(ponline(@arg[0]))
    {
    set_ponfire(@arg[0], 1200);
    tmsg(@sender, '§f[ §4R§8C §f] Incinerating §7'.@arg[0].'§f.');
    }
   else
    {
    tmsg(@sender, '§f[ §4R§8C §f] Player §7'.@arg[0].' §fnot found.');
    }
   return(true);
   }
  return(false);
  }
 ));

######## CRASH ########
register_command('crash', array(
 'description': 'Crashes the client of the target player.',
 'usage': '§f[ §4R§8C §f] Usage: /crash <player>',
 'permission': 'refinecraft.crash',
 'noPermMsg': '§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f',
 'tabcompleter': closure(@alias, @sender, @arg)
  {
  if(array_size(@arg) == 0)
   {
   return(all_players());
   }
  @search = @arg[array_size(@arg) - 1];
  return(array_filter(all_players(), closure(@index, @player)
   {
   return(equals_ic(@search, substr(@player, 0, length(@search))));
   }));
  },
 'aliases': array('crashalias'),
 'executor': closure(@alias, @sender, @arg)
  {
  if(array_size(@arg) == 1)
   {
   if(ponline(@arg[0]))
    {
    tmsg(@sender, '§f[ §4R§8C §f] Crashing §7'.@arg[0].'§f.');
    for(@i = 0, @i < 10000, ++@i)
     {
     psend_block_change(@arg[0], ploc(@arg[0]), 11);
     psend_block_change(@arg[0], ploc(@arg[0]), 0);
     }
    }
   else
    {
    tmsg(@sender, '§f[ §4R§8C §f] Player §7'.@arg[0].' §fnot found.');
    }
   return(true);
   }
  return(false);
  }
 ));

######## TELEPORT ########
register_command('tp', array(
 'description': 'Teleport to another player or destination.',
 'usage': '§f[ §4R§8C §f] Usage: /teleport <player>',
 'permission': 'refinecraft.teleport',
 'noPermMsg': '§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f',
 'tabcompleter': closure(@alias, @sender, @arg)
  {
  if(array_size(@arg) == 0)
   {
   return(all_players());
   }
  @search = @arg[array_size(@arg) - 1];
  return(array_filter(all_players(), closure(@index, @player)
   {
   return(equals_ic(@search, substr(@player, 0, length(@search))));
   }));
  },
 'aliases': array('teleport', 'tpa'),
 'executor': closure(@alias, @sender, @arg)
  {
  if(has_permission(@sender, 'refinecraft.teleport.override'))
   {
   if(array_size(@arg) == 1)
    {
    if(ponline(@arg[0]))
     {
     if(@sender != @arg[0])
      {
      tmsg(@sender, @sender @arg[0])
      tmsg(@sender, '§f[ §4R§8C §f] Teleporting §7you §fto §7'.@arg[0].'§f.');
      set_ploc(@sender, ploc(@arg[0]));
      }
     else
      {
      tmsg(@sender, '§f[ §4R§8C §f] You cannot teleport to yourself.');
      }
     }
    else
     {
     tmsg(@sender, '§f[ §4R§8C §f] Player §7'.@arg[0].' §fnot found.');
     }
    return(true);
    }
   else if(array_size(@arg) == 2)
    {
    if(ponline(@arg[0]))
     {
     if(ponline(@arg[1]))
      {
      if(@arg[0] != @arg[1])
       {
       tmsg(@sender, '§f[ §4R§8C §f] Teleporting §7'.@arg[0].' §fto §7'.@arg[1].'§f.');
       set_ploc(@arg[0], ploc(@arg[1]));
       }
      else
       {
       tmsg(@sender, '§f[ §4R§8C §f] You cannot teleport a player to the same player.');
       }
      }
     else
      {
      tmsg(@sender, '§f[ §4R§8C §f] Player §7'.@arg[1].' §fnot found.');
      }
     }
    else
     {
     tmsg(@sender, '§f[ §4R§8C §f] Player §7'.@arg[0].' §fnot found.');
     }
    return(true);
    }
   }
  else
   {
   if(array_size(@arg) == 1)
    {
    if(ponline(@arg[0]))
     {
     if(@sender != @arg[0])
      {
      if(get_value(@arg[0].'.teleport') == @sender)
       {
       tmsg(@sender, '§f[ §4R§8C §f] Teleport request pending.');
       }
      else
       {
       store_value(@arg[0].'.teleport', @sender);
       tmsg(@sender, '§f[ §4R§8C §f] Teleport request sent to §o'.@arg[0].'§r.');
       tmsg(@arg[0], '§f[ §4R§8C §f] Teleport request recieved from §o'.@sender.'§r.\n§fType §7/tpaccept §fto accept or §7/tpdeny §fto deny.');
       }
      }
     else
      {
      tmsg(@sender, '§f[ §4R§8C §f] You cannot teleport to yourself.');
      }
     }
    else
     {
     tmsg(@sender, '§f[ §4R§8C §f] Player §7'.@arg[0].' §fnot found.');
     }
    return(true);
    }
   }
  return(false);
  }
 ));

######## tpaccept ########
register_command('tpaccept', array(
 'description': 'null',
 'usage': '§f[ §4R§8C §f] Usage: /tpaccept',
 'permission': 'refinecraft.teleport',
 'noPermMsg': '§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f',
 'tabcompleter': closure(@alias, @sender, @arg)
  {
  if(array_size(@arg) == 0)
   {
   return(all_players());
   }
  @search = @arg[array_size(@arg) - 1];
  return(array_filter(all_players(), closure(@index, @player)
   {
   return(equals_ic(@search, substr(@player, 0, length(@search))));
   }));
  },
 'aliases': array('teleportaccept'),
 'executor': closure(@alias, @sender, @arg)
  {
  if(array_size(@arg) == 0)
   {
   if(get_value(@sender.'.teleport') == null)
    {
    die('§f[ §4R§8C §f] You have no pending teleport requests.');
    }
   @target = get_value(@sender.'.teleport');
   clear_value(@sender.'.teleport');
   if (ponline(@target) == false)
    {
    die('§f[ §4R§8C §f] Player not found.');
    }
   @x = ploc(@target)[0];
   @y = ploc(@target)[1] + 1;
   @z = ploc(@target)[2];
   for(@i = 0, @i < 50, @i++)
    {
    make_effect(array(@x, @y, @z), 'ENDER_SIGNAL');
    }
   play_sound(ploc(@target), array('sound':'ENDERMAN_TELEPORT', 'volume':'1', 'pitch':'1'));
   set_ploc(@target, ploc(@sender));
   @x = ploc(@target)[0];
   @y = ploc(@target)[1] + 1;
   @z = ploc(@target)[2];
   for(@i = 0, @i < 50, @i++)
    {
    make_effect(array(@x, @y, @z), 'ENDER_SIGNAL');
    }
   play_sound(ploc(@target), array('sound':'ENDERMAN_TELEPORT', 'volume':'1', 'pitch':'1'));
   tmsg(@sender, '§f[ §4R§8C §f] Teleporting§o' @target '§rto §oyou §f.');
   tmsg(@target, '§f[ §4R§8C §f] Teleport request to§o' @sender '§raccepted.\n§f[ §4R§8C §f] Teleporting §oyou §f to§o' @sender.'§f.');
   return(true);
   }
  return(false);
  }
 ));

########  ########
register_command('test', array(
 'description': '',
 'usage': '§f[ §4R§8C §f] Usage: / <player>',
 'permission': 'refinecraft.',
 'noPermMsg': '§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f',
 'tabcompleter': closure(@alias, @sender, @arg)
  {
  if(array_size(@arg) == 0)
   {
   return(all_players());
   }
  @search = @arg[array_size(@arg) - 1];
  return(array_filter(all_players(), closure(@index, @player)
   {
   return(equals_ic(@search, substr(@player, 0, length(@search))));
   }));
  },
 'aliases': array('testalias'),
 'executor': closure(@alias, @sender, @arg)
  {
  if(array_size(@arg) == 1)
   {
   if(ponline(@arg[0]))
    {
    @config = yml_decode(comp_read('RefineCraft/config.yml'));
    broadcast(@config['configversion']['notify']);
    }
   else
    {
    tmsg(@sender, '§f[ §4R§8C §f] Player §7'.@arg[0].' §fnot found.');
    }
   return(true);
   }
  return(false);
  }
 ));
 
