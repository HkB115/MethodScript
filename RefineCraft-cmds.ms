#*:/display [$player] [$cmd] [$=''] = >>>
# broadcast('§c'.$player.':' $cmd $)
#<<<

*:/test [$=''] = >>>
 @loc = ploc(player());
 @loc['1'] = 5;
 @loc['y'] = 5;
 @e0 = spawn_entity('WITHER', 1, @loc)[0];
 set_mob_name(@e0, 'TESTMESSAGE');
 set_name_visible(@e0, true);
 x_new_thread('scoreboard', closure()
  {
  sleep(1);
  x_run_on_main_thread_later(closure()
   {
   entity_remove(@e0);
   });
  });
 #make_effect(array(@loc['0'], @loc['1'] + 1, @loc['2']), 'EXPLOSION_HUGE', 50);
<<<

*:/ban [$target=''] [$reason='Not Given'] = >>>
 if(has_permission('refinecraft.ban'))
  {
  if($target == '')
   {
   die('§f[ §4R§8C §f] Usage: /ban <player>  [reason]')
   }
  #call_alias(/display player() '/ban' $target $reason)
  pkick($target, '§4Refine§8Craft §fControl\nAction: §cBan §f\nReason: §c' . $reason '§f\nhttp://www.Refination.net/')
  sudo('/minecraft:ban' $target '§4Refine§8Craft §fControl\nAction: §cBan §f\nReason: §c' . $reason '§f\nhttp://www.Refination.net/')
  msg('§f[ §4R§8C §f] Player banned.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/ban-ip [$ip=''] [$reason='Not Given'] = >>>
 if (has_permission('refinecraft.ban-ip'))
  {
  if ($ip == '')
   {
   die('§f[ §4R§8C §f] Usage: /ban-ip <IP> [reason]')
   }
  #call_alias(/display player() '/ban-ip' $ip $reason)
  sudo('/minecraft:ban-ip' $ip '§4Refine§8Craft §fControl\nAction: §c[IP] Ban §f\nReason: §c' . $reason '§f\nhttp://www.Refination.net/')
  msg('§f[ §4R§8C §f] IP Banned.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/banlist [$=''] = >>>
 if (has_permission('refinecraft.banlist'))
  {
  msg(get_banned_players())
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/break [$=''] = >>>
 if(has_permission('refinecraft.break'))
  {
  #call_alias(/display player() '/break' $)
  break_block(pcursor())
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/broadcast [$=''] = >>>
 if(has_permission('refinecraft.broadcast'))
  {
  broadcast('§f[ §4R§8C §f]' $)
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/clear [$option=''] [$target=''] [$=''] = >>>
 if (has_permission('refinecraft.clear'))
  {
  if ($option == 'chat')
   {
   for(@i = 0, @i < 100, @i++)
    {
    broadcast('\n')
    }
   #call_alias(/display player() '/clear' $option $target $)
   broadcast('§0[§4Refine§8Craft§0] §fChat Cleared.')
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/recompile [$=''] = >>>
 if(has_permission('refinecraft.compile'))
  {
  sudo(/reloadaliases $)
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/death [$player] = >>>
 if (has_permission('refinecraft.death'))
  {
  if ($player == '')
   {
   @player = player()
   }
  else
   {
   @player = $player
   }
  @death = get_value(@player . '.death')
  if (@death == null)
   {
   die('§f[ §4R§8C §f] Location of death not found.')
   }
  @x = round(@death[0])
  @y = round(@death[1])
  @z = round(@death[2])
  @world = @death[3]
  psend_block_change(@player, array(@x, @y-2, @z), '42')
  psend_block_change(@player, array(@x+1, @y-2, @z), '42')
  psend_block_change(@player, array(@x+1, @y-2, @z+1), '42')
  psend_block_change(@player, array(@x, @y-2, @z+1), '42')
  psend_block_change(@player, array(@x-1, @y-2, @z+1), '42')
  psend_block_change(@player, array(@x-1, @y-2, @z), '42')
  psend_block_change(@player, array(@x-1, @y-2, @z-1), '42')
  psend_block_change(@player, array(@x, @y-2, @z-1), '42')
  psend_block_change(@player, array(@x+1, @y-2, @z-1), '42')
  psend_block_change(@player, array(@x, @y-1, @z), '138')
  psend_block_change(@player, array(@x+1, @y-1, @z), '169')
  psend_block_change(@player, array(@x+1, @y-1, @z+1), '41')
  psend_block_change(@player, array(@x, @y-1, @z+1), '169')
  psend_block_change(@player, array(@x-1, @y-1, @z+1), '41')
  psend_block_change(@player, array(@x-1, @y-1, @z), '169')
  psend_block_change(@player, array(@x-1, @y-1, @z-1), '41')
  psend_block_change(@player, array(@x, @y-1, @z-1), '169')
  psend_block_change(@player, array(@x+1, @y-1, @z-1), '41')
  psend_block_change(@player, array(@x, @y, @z), '95:14')
  if (@world == 'world_creative')
   {
   @world = 'Creative'
   }
  else if (@world == 'world_spawn')
   {
   @world = 'Spawn'
   }
  else if (@world == 'world_survival_havoc')
   {
   @world = 'Havoc - Overworld'
   }
  else if (@world == 'world_survival_havoc_nether')
   {
   @world = 'Havoc - Underworld'
   }
  else if (@world == 'world_survival_normal')
   {
   @world = 'Survival - Overworld'
   }
  else if (@world == 'world_survival_normal_nether')
   {
   @world = 'Survival - Nether'
   }
  else if (@world == 'world_survival_normal_the_end')
   {
   @world = 'Survival - The End'
   }
  else
   {
   @world = 'Inaccessible Area'
   }
  die('§f[ §4R§8C §f] Death Point: §7' . @x @y @z '§fin §7' . @world . '§f.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/debug [$=''] = >>>
 if(has_permission('refinecraft.debug'))
  {
  if($ == 'block')
   {
   msg(get_block_at(pcursor(player())));
   msg(get_block_info(pcursor(player())));
   }
  if($ == 'clock')
   {
   @time1 = nano_time();
   for(@i = 0, @i < 1000, ++@i)
    {
    }
   @time2 = nano_time();
   @tps = (@time2 - @time1)/1000000;
   msg(@tps);
   }
  if($ == 'info')
   {
   msg(sys_properties());
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f');
  }
<<<

*:/fakeblock [$block=''] = >>>
 if (has_permission('refinecraft.fakeblock'))
  {
  if ($block == '')
   {
   @block = 1
   }
  else
   {
   @block = $block
   }
  if ($block == 'rand')
   {
   @block = rand(0,182)
   }
  foreach(all_players(), @player, psend_block_change(@player, pcursor(player()), @block))
  tmsg(player(), '§f[ §4R§8C §f] Fake block produced at cursor position.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/fly [$speed=''] [$=''] = >>>
 if(has_permission('refinecraft.fly'))
  {
  #call_alias(/display player() '/fly' $speed $)
  if(($speed == ''))
   {
   assign(@speed, 1)
   }
  if(($speed != ''))
   {
   assign(@speed, $speed)
   }
  if(@speed == 'off')
   {
   set_pflight(player(), 0)
   set_pflyspeed(player(), 0.1)
   msg('§f[ §4R§8C §f] Flight §7disabled')
   }
  else
   {
   set_pflight(player(), flight)
   set_pflyspeed(player(), @speed / 10)
   msg('§f[ §4R§8C §f] Flight §7enabled §fat speed §7' . @speed)
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/gm [$] = call_alias(/gamemode $)
*:/gamemode [$gamemode=''] [$player=''] [$=''] = >>>
 if(has_permission('refinecraft.gamemode'))
  {
  if(($player == ''))
   {
   assign(@player, player())
   }
  if(($player != ''))
   {
   assign(@player, player($player))
   }
  if(($gamemode == 'survival')||($gamemode == 0))
   {
   #call_alias(/display player() '/gamemode' $gamemode $player $)
   set_pmode(@player, 'survival')
   if(@player != player())
    {
    tmsg(player(), '§f[ §4R§8C §f]§7'@player '§fgamemode has been changed to §7survival§f.')
    }
   tmsg(@player, '§f[ §4R§8C §f] Your gamemode has been changed to §7survival§f.')
   }
  else if(($gamemode == 'creative')||($gamemode == 1))
   {
   #call_alias(/display player() '/gamemode' $gamemode $player $)
   set_pmode(@player, 'creative')
   if(@player != player())
    {
    tmsg(player(), '§f[ §4R§8C §f]§7'@player '§fgamemode has been changed to §7creative§f.')
    }
   tmsg(@player, '§f[ §4R§8C §f] Your gamemode has been changed to §7creative§f.')
   }
  else if(($gamemode == 'adventure')||($gamemode == 2))
   {
   #call_alias(/display player() '/gamemode' $gamemode $player $)
   set_pmode(@player, 'adventure')
   if(@player != player())
    {
    tmsg(player(), '§f[ §4R§8C §f]§7'@player '§fgamemode has been changed to §7adventure§f.')
    }
   tmsg(@player, '§f[ §4R§8C §f] Your gamemode has been changed to §7adventure§f.')
   }
  else if(($gamemode == 'spectator')||($gamemode == 3))
   {
   #call_alias(/display player() '/gamemode' $gamemode $player $)
   set_pmode(@player, 'spectator')
   if(@player != player())
    {
    tmsg(player(), '§f[ §4R§8C §f]§7'@player '§fgamemode has been changed to §7spectator§f.')
    }
   tmsg(@player, '§f[ §4R§8C §f] Your gamemode has been changed to §7spectator§f.')
   }
  else
   {
   die('§f[ §4R§8C §f] Usage: /gamemode <mode> [player]')
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/gburn [$=''] = >>>
 if(has_permission('refinecraft.burn.global'))
  {
  #call_alias(/display player() '/gburn' $)
  foreach(all_players(), @player)
   {
   set_ponfire(@player, 1200)
   }
  msg('§f[ §4R§8C §f] Players burned.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

#*:/ghost [$par='toggle'] [$=''] = >>>
# if(has_permission('refinecraft.ghost'))
#  {
#  @player = player()
#  @ghost = get_value(player() . '.ghost')
#  if(@ghost == null)
#   {
#   @ghost = false
#   }
#  if($par == 'on')
#   {
#   @ghost = true
#   }
#  if($par == 'off')
#   {
#   @ghost = false
#   }
#  if($par == 'fj')
#   {
#   @ghost = false
#   broadcast('§e' . player() '§ejoined the game.')
#   }
#  else if($par == 'fq')
#   {
#   @ghost = true
#   broadcast('§e' . player() '§eleft the game.')
#   }
#  if(($par == 'toggle')&&(@ghost == false))
#   {
#   @ghost = true
#   }
#  else if(($par == 'toggle')&&(@ghost == true))
#   {
#   @ghost = false
#   }
#  @y = ploc()[1]
#  for(@a = 0, @a < 50, @a++)
#   {
#   if (has_permission('refinecraft.ghost.effect.flames'))
#    {
#    make_effect(array(ploc()[0], @y+1, ploc()[2]), 'MOBSPAWNER_FLAMES')
#    }
#   if (has_permission('refinecraft.ghost.effect.smoke'))
#    {
#    make_effect(array(ploc()[0], @y+1, ploc()[2]), 'SMOKE:' . rand(0,9))
#    }
#   }
#  if(@ghost == true)
#   {
#   set_pmode(player(), 'spectator')
#   }
#  else if(@ghost == false)
#   {
#   set_pmode(player(), 'survival')
#   }
#  foreach(all_players(), @p)
#   {
#   if(has_permission(@p, 'refinecraft.ghost.see'))
#    {
#    if((@ghost == true)&&(@p != @player))
#     {
#     tmsg(@p, '§f[ §4R§8C §f] §o' . @player '§renabled ghost.')
#     }
#    if((@ghost == false)&&(@p != @player))
#     {
#     tmsg(@p, '§f[ §4R§8C §f] §o' . @player '§rdisabled ghost.')
#     }
#    if((@ghost == true)&&(@p == @player))
#     {
#     msg('§f[ §4R§8C §f] Ghost mode enabled.')
#     }
#    if((@ghost == false)&&(@p == @player))
#     {
#     msg('§f[ §4R§8C §f] Ghost mode disabled.')
#     }
#    }
#   else
#    {
#    raw_set_pvanish(player(), @ghost, @p)
#    }
#   }
#  store_value(@player . '.ghost', @ghost)
#  ##call_alias(/display player() '/ghost' $par $)
#  }
# else
#  {
#  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
#  }
#<<<

*:/v [$=''] = call_alias(/ghost $)
*:/vanish [$=''] = call_alias(/ghost $)
*:/ghost [$par='toggle'] = >>>
 if(has_permission('refinecraft.ghost'))
  {
  @par = $par
  @player = player()
  @ghost = get_value(@player.'.ghost')
  if((@ghost == null)||(@par == 'disable')||(@par == 'false')||(@par == 'fj')||(@par == 'off'))
   {
   @ghost = false
   }
  if((@par == 'enable')||(@par == 'fq')||(@par == 'on'))
   {
   @ghost = true
   }
  if((@par == 'toggle')&&(@ghost == false))
   {
   @ghost = true
   }
  else if(($par == 'toggle')&&(@ghost == true))
   {
   @ghost = false
   }
  if(@ghost != get_value(@player.'.ghost'))
   {
   store_value(@player.'.ghost', @ghost)
   @y = ploc()[1]
   for(@i = 0, @i < 50, @i++)
    {
    if(has_permission('refinecraft.ghost.effect.flames'))
     {
     make_effect(array(ploc()[0], @y+1, ploc()[2]), 'MOBSPAWNER_FLAMES')
     }
    if(has_permission('refinecraft.ghost.effect.smoke'))
     {
     make_effect(array(ploc()[0], @y+1, ploc()[2]), 'SMOKE:' . rand(0,9))
     }
    }
   foreach(all_players(), @other)
    {
    raw_set_pvanish(@player, @ghost, @other)
    if(has_permission(@other, 'refinecraft.ghost.see'))
     {
     raw_set_pvanish(@player, false, @other)
     }
    else
     {
     raw_set_pvanish(@player, true, @other)
     }
    if(has_permission(@other, 'refinecraft.ghost.alerts'))
     {
     if((@ghost == true)&&(@other != @player))
      {
      tmsg(@other, '§f[§3info§f] §o'.@player '§rvanished.')
      }
     if((@ghost == false)&&(@other != @player))
      {
      tmsg(@other, '§f[§3info§f] §o'.@player '§rbecame visible.')
      }
     if((@ghost == true)&&(@other == @player))
      {
      msg('§f[§3info§f] Ghost enabled.')
      }
     if((@ghost == false)&&(@other == @player))
      {
      msg('§f[§3info§f] Ghost disabled.')
      }
     }
    }
   if(get_value(@player.'.ghost') == true)
    {
    if(length(@player) > 14)
     {
     set_list_name(@player, '§8'.substr(@player, 0, 13));
     }
    else
     {
     set_list_name(@player, '§8'.@player);
     }
    }
   else
    {
    if(array_contains(pgroup(@player), overseer))
     {
     if(length(@player) > 14)
      {
      set_list_name(@player, '§4'.substr(@player, 0, 13))
      }
     else
      {
      set_list_name(@player, '§4'.@player)
      }
     }
    else if(array_contains(pgroup(@player), administrator))
     {
     if(length(@player) > 14)
      {
      set_list_name(@player, '§3'.substr(@player, 0, 13))
      }
     else
      {
      set_list_name(@player, '§3'.@player)
      }
     }
    else if(array_contains(pgroup(@player), moderator))
     {
     if(length(@player) > 14)
      {
      set_list_name(@player, '§2'.substr(@player, 0, 13))
      }
     else
      {
      set_list_name(@player, '§2'.@player)
      }
     }
    else
     {
     if(length(@player) > 14)
      {
      set_list_name(@player, '§f'.substr(@player, 0, 13))
      }
     else
      {
      set_list_name(@player, '§f'.@player)
      }
     }
    }
   }
  if((@par == 'fj')&&(has_permission('refinecraft.ghost.silentjoin')))
   {
   broadcast('§e'.@player 'connected.')
   }
  if((@par == 'fq')&&(has_permission('refinecraft.ghost.silentquit')))
   {
   broadcast('§e'.@player 'disconnected.')
   }
  if((@par == 'list')&&(has_permission('refinecraft.ghost.list')))
   {
   @vlist = 'Refiner'
   foreach(all_players(), @other)
    {
    if(get_value(@other.'.ghost') == true)
     {
     @vlist = concat(@vlist, ', '.@other)
     }
    }
   tmsg(@player, '§f[ §4R§8C §f] Ghost Players: '.@vlist)
   }
  }
 else
  {
  die('§f[§6warn§f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[§3info§f] Available options found in /help§f')
  }
<<<

*:/item [$] = call_alias(/give $)
*:/give [$player=''] [$item=''] [$quantity=1] [$dataTag] [$=''] = >>>
 if(has_permission('refinecraft.give'))
  {
  if($player == '')
   {
   @player = player()
   }
  else
   {
   @player = $player
   }
  if($item == '')
   {
   die('§f[ §4R§8C §f] Usage: /give <player> <item> [quantity] [dataTag]')
   }
  else
   {
   @item = $item
   #call_alias(/display player() '/give' @player @item $quantity $dataTag $)
   sudo('/minecraft:give' @player @item $quantity $dataTag)
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/gkick [$reason='Not Given'] [$] = >>>
 if(has_permission('refinecraft.kick.global'))
  {
  #call_alias(/display player() '/gkick' $reason $)
  foreach(all_players(), @player)
   {
   pkick(@player, '§4Refine§8Craft §fControl\nAction: §c[GLOBAL] Kick §f\nReason: §c' . $reason '§f\nhttp://www.Refination.net/')
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/gkill [$=''] = >>>
 if(has_permission('refinecraft.kill.global'))
  {
  #call_alias(/display player() '/gkill' $)
  foreach(all_players(), @player)
   {
   pkill(@player)
   }
  msg('§f[ §4R§8C §f] Players killed.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/god [$=''] = #call_alias(/display player() '/god' $)

*:/hat [$=''] = >>>
 if(has_permission('refinecraft.hat'))
  {
  assign(@player, player())
  if(is_null(pinv(@player, null)))
   {
   die('§f[ §4R§8C §f] You must be holding an item.')
   }
  try(set_pinv(array(103: pinv(player(), null))), @i, die('§f[ §4R§8C §f] You cannot wear that item.'))
  #call_alias(/display player() '/hat' $)
  msg('§f[ §4R§8C §f] Hat successful.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/heal [$target=''] [$] = >>>
 if(has_permission('refinecraft.heal'))
  {
  #call_alias(/display player() '/heal' $target $)
  if($target == '')
   {
   assign(@target, player())
   }
  else
   {
   assign(@target, $target)
   }
  set_phealth(@target, 20)
  set_phunger(@target, 20)
  tmsg(@target, '§f[ §4R§8C §f] Your health and hunger have been restored.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/home [$player=''] = >>>
 if (has_permission('refinecraft.home'))
  {
  if($player == '')
   {
   @player = player()
   }
  else
   {
   @player = $player
   }
  if(is_null(get_value(player() . '.home')))
   {
   die('§f[ §4R§8C §f] You currently do not have a home. To set your home, sleep in a bed.')
   }
  else if((length(entities_in_radius(ploc(@player), 15, array(WITHER_SKULL, GUARDIAN, WITHER, SKELETON, FIREBALL, FALLING_BLOCK, WEATHER, PIG_ZOMBIE, ENDERMAN, LIGHTNING, GHAST, SPIDER, GIANT, CREEPER, SMALL_FIREBALL, CAVE_SPIDER, MAGMA_CUBE, SPLASH_POTION, ENDER_DRAGON, BLAZE, ENDERMITE, PRIMED_TNT, SILVERFISH, SLIME, ZOMBIE, WITCH))) > 0)||(ponfire(@player) > 0))
   {
   die('§f[ §4R§8C §f] You cannot teleport home when there is danger close.')
   }
  else
   {
   assign(@loc, get_value(player() . '.home'))
   for(@i = 0, @i < 50, @i++)
    {
    make_effect(array(@loc[0], @loc[1], @loc[2]), 'ENDER_SIGNAL')
    }
   play_sound(@loc, array('sound':'ENDERMAN_TELEPORT', 'volume':'1', 'pitch':'1'))
   set_ploc(@player, @loc)
  die('§f[ §4R§8C §f] Home: ' . round(@loc[0]) round(@loc[1]) round(@loc[2]))
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/j [$] = call_alias(/jumpto $)
*:/jumpto [$] = >>>
 if(has_permission('refinecraft.jumpto'))
  {
  #call_alias(/display player() '/jumpto' $)
  @y = ploc()[1]
  for(@i = 0, @i < 50, @i++)
   {
   make_effect(array(ploc()[0], @y+1, ploc()[2]), 'ENDER_SIGNAL')
   }
  play_sound(ploc(), array('sound':'ENDERMAN_TELEPORT', 'volume':'1', 'pitch':'1'))
  @x = pinfo(player(), 2)[0] + 0.5
  @y = pinfo(player(), 2)[1] + 1.0
  @z = pinfo(player(), 2)[2] + 0.5
  set_ploc(player(), array(@x, @y, @z))
  @y = ploc()[1]
  for(@i = 0, @i < 50, @i++)
   {
   make_effect(array(ploc()[0], @y+1, ploc()[2]), 'ENDER_SIGNAL')
   }
  play_sound(ploc(), array('sound':'ENDERMAN_TELEPORT', 'volume':'1', 'pitch':'1'))
  msg('§f[ §4R§8C §f] Teleported to cursor position.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/kick [$target=''] [$reason='Not Given'] = >>>
 if(has_permission('refinecraft.kick'))
  {
  if($target == '')
   {
   die('§f[ §4R§8C §f] Usage: /kick <player> [reason]')
   }
  try(@target = player($target), die('§f[ §4R§8C §f] Player not found.'))
  #call_alias(/display player() '/kick' @target $reason)
  pkick(@target, '§4Refine§8Craft §fControl\nAction: §cKick §f\nReason: §c' . $reason '§f\nhttp://www.Refination.net/')
  msg('§f[ §4R§8C §f] Player kicked.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/kill [$target=''] [$=''] = >>>
 if(has_permission('refinecraft.kill'))
  {
  if($target == '')
   {
   die('§f[ §4R§8C §f] Usage: /kill <player>')
   }
  try(@target = player($target), die('§f[ §4R§8C §f] Player not found.'))
  #call_alias(/display player() '/kill' $target $)
  pkill(@target)
  msg('§f[ §4R§8C §f] Player killed.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/list [$=''] = >>>
 if(has_permission('refinecraft.list'))
  {
  die('Default Mapping: &cHold &f<TAB> &cto view a list of currently online players.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/magic [$=''] = >>>
@loc = ploc(player())
@loc[1] = @loc[1] + 1
@cursor = pcursor(player())
@cursor[1] = @cursor[1] + 1
shoot_projectile(@loc, LIGHTNING, @cursor, 1)

<<<

*:/msg [$=''] = call_alias(/message $)
*:/pm [$=''] = call_alias(/message $)
*:/tell [$=''] = call_alias(/message $)
*:/w [$=''] = call_alias(/message $)
*:/whisper [$=''] = call_alias(/message $)
*:/message [$target=''] [$message=''] = >>>
 if (has_permission('refinecraft.message'))
  {
  @message = $message
  if (($target == '')||(@message == ''))
   {
   die('§f[ §4R§8C §f] Usage: /message <player> <message>')
   }
  try(@target = player($target), die('§f[ §4R§8C §f] Player not found.'))
  if (player () == @target)
   {
   die('§f[ §4R§8C §f] You cannot message yourself.')
   }
  store_value(player() . '.messaging', @target)
  tmsg(player(), '§8(§f', @target, '§8) §4<- §f'.@message)
  tmsg(@target, '§8(§f', player(), '§8) §4-> §f'.@message)
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[§binfo§f] Available options found in /help§f')
  }
<<<

*:/mirv [$rad=1] [$ex=1] [$target=''] [$=''] = >>>
 if (has_permission('refinecraft.mirv'))
  {
  if($target == '')
   {
   @target = player()
   }
  else
   {
   @target = player($target)
   }
  ##call_alias(/display player() '/mirv' $rad $ex @target $)
  @launch = ploc(@target)
  @drop = ploc(@target)
  @launch['y'] = 255
  @drop['y'] = 254
  @radius = $rad
  tmsg(@target, '§f[ §4R§8C §f] Nuclear fire rains down upon you.')
  for(@i=0, @i < ($ex * 250), ++@i)
   {
   @deg = rand(0,360)
   @x = cos(@deg) * @radius * (rand(1,100) / 500)
   @z = sin(@deg) * @radius * (rand(1,100) / 500)
   @drop['x'] = @launch['x'] + @x
   @drop['z'] = @launch['z'] + @z
   spawn_entity(PRIMED_TNT, 1, @drop)
   }
  for(@i=0, @i < 8, ++@i)
   {
   explosion(@launch, 15, true)
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/music [$cd=''] = >>>
 assign(@cd, to_lower($cd))
 if((@cd == '11')||(@cd == '13')||(@cd == 'blocks')||(@cd == 'cat')||(@cd == 'chirp')||(@cd == 'far')||(@cd == 'mall')||(@cd == 'mellohi')||(@cd == 'stal')||(@cd == 'strad')||(@cd == 'wait')||(@cd == 'ward'))
  {
  runas(~console, '/minecraft:playsound records.' . @cd player() '~0 ~0 ~0 10000 1.0')
  msg('§fNow Playing: §b' @cd)
  }
 else
  {
  msg('§f[ §4R§8C §f] Usage: /music <record>')
  die('Options: 11, 13, Blocks, Cat, Chirp, Far, Mall, Mellohi, Stal, Strad, Wait, Ward')
  }
<<<

*:/ping [$=''] = >>>
 msg('--- Refination ping statistics ---')
 msg('1 packets transmitted, 1 received, 0% packet loss, time ', rand(25,250), 'ms')
<<<

*:/pl [$=''] = call_alias(/plugins $)
*:/plugins [$=''] = >>>
 if(has_permission('refinecraft.plugins'))
  {
  die('Plugins (6): §aRCchat§f, §aRCcmds§f, §aRCctrl§f, §aRChelp§f, §aRCutil§f, §aRefineCraft§f')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/r [$=''] = call_alias(/reply $)
*:/reply [$message=''] = >>>
 if(has_permission('refinecraft.message'))
  {
  @message = $message
  if(@message == '')
   {
   die('§f[ §4R§8C §f] Usage: /reply <message>')
   }
  try(
  @target = get_value(player() . '.messaging')
  if (@target == null)
   {
   die('§f[ §4R§8C §f] No message to reply to.')
   }
  tmsg(player(), '§8(§f', @target, '§8) §4<- §f' . @message)
  tmsg(@target, '§8(§f', player(), '§8) §4-> §f' . @message)
  store_value(pinfo(@target, 0) . '.messaging', player())
  , @e ,
  clear_value(player() . '.messaging')
  die('§f[ §4R§8C §f] §o' . @target '§ris no longer online.')
  )
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[§binfo§f] Available options found in /help§f')
  }
<<<

#*:/rocket [$player=''] = >>>
# if($player == '')
#  {
#  @player = player()
#  }
# else
#  {
#  try(@player = player($player), msg('offline'))
#  }
# try(@playerid = entity_id(puuid(@player)), msg('[ERR] rocket'))
# @velocity = entity_velocity(@playerid)
# @velocity[y] = 9999999
# set_entity_velocity(@playerid, @velocity)
#<<<

*:/say [$message=''] = >>>
 if(has_permission('refinecraft.say'))
  {
  #call_alias(/display player() '/say' $message)
  broadcast('§f<§4Overseer §8┃ §fRefiner§f> §f' . $message)
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/seed [$=''] = >>>
 tmsg(player(), '3.14159265358979323846264338327950288419716939937510582097494459230781640628620899862803482534211706798214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196442881097566593344612847564823378678316527120190914564856692346034861045432664821339360726024914127372458700660631558817488152092096282925409171536436789259036001133053054882046652138414695194151160943305727036575959195309218611738193261179310511854807446237996274956735188575272489122793818301194912983367336244065664308602139494639522473719070217986094370277053921717629317675238467481846766940513200056812714526356082778577134275778960917363717872146844090122495343014654958537105079227968925892354201995611212902196086403441815981362977477130996051870721134999999')
<<<

*:/seen [$player=''] = >>>
 if (has_permission('refinecraft.seen'))
  {
  if($player == '')
   {
   assign(@player, $player)
   }
  else
   {
   assign(@player, $player)
   }
  msg('§f[ §4R§8C §f]§7' @player '§fwas last online§7' plast_played(@player))
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

# Deprecated
#*:/sethome [$home='Unnamed'] = >>>
# if (has_permission('refinecraft.cmds.home.set'))
#  {
#  store_value(player() . '.home', ploc())
#  set_compass_target(player(), ploc())
#  die('§f[ §4R§8C §f] Home set.')
#  }
# else
#  {
#  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
#  }
#<<<

*:/spawner [$type=''] [$=''] = >>>
 if(has_permission('refinecraft.spawner'))
  {
  if($type == '')
   {
   die('§f[ §4R§8C §f] Usage: /spawner <type>')
   }
  else
   {
   #call_alias(/display player() '/spawner' $type $)
   set_spawner_type(pcursor(), $type)
   msg('§f[ §4R§8C §f] Spawner modified.')
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/sudo [$command=''] [$=''] = >>>
 if(has_permission('refinecraft.sudo'))
  {
  #call_alias(/display player() '/sudo' $command $)
  sudo('/' . $command $)
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/suicide [$=''] = >>>
 if (has_permission('refinecraft.suicide'))
  {
  @death = rand(1,2)
  if (@death == 1)
   {
   explosion(ploc(player()), 0, true)
   pkill(player())
   }
  if (@death == 2)
   {
   lightning(ploc(player()), true)
   pkill(player())
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/summon [$entity=''] [$quantity=1] [$dataTag] [$=''] = >>>
 if(has_permission('refinecraft.summon'))
  {
  if($entity == '')
   {
   die('§f[ §4R§8C §f] Usage: /summon <entity> [quantity] [{dataTag}]')
   }
  else
   {
   #call_alias(/display player() '/summon' $entity $quantity $dataTag $)
   @x = pinfo(player(), 2)[0] + 0.5
   @y = pinfo(player(), 2)[1] + 1.0
   @z = pinfo(player(), 2)[2] + 0.5
   for(@i = 0, @i < $quantity, ++@i)
    {
    sudo('/summon' $entity @x @y @z $dataTag)
    }
   msg('§f[ §4R§8C §f] Entities summoned.')
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<



*:/tpdeny [$=''] = >>>
 if (get_value(player().'.teleport') == null)
  {
  die('§f[ §4R§8C §f] You have no pending teleport requests.')
  }
 @player = player()
 @target = get_value(player().'.teleport')
 clear_value(@player . '.teleport')
 if (ponline(@target) == false)
  {
  die('§f[ §4R§8C §f] Player not found.')
  }
 tmsg(@player, '§f[ §4R§8C §f] Teleport request from §o' . @target '§rdenied.')
 tmsg(@target, '§f[ §4R§8C §f] Teleport request to §o' . @player . '§rdenied.')
<<<

# Deprecated
#*:/tphere [$target=''] = >>>
# if ($target == '')
#  {
#  die('§f[ §4R§8C §f] Usage: /tpahere <player>')
#  }
# try(@target = player($target),die('§f[ §4R§8C §f] Player not found.'))
# @tpahere = get_value(@target . '.tpahere')
# if (array_indexes(@tpahere, @target) != '{}')
#  {
#  die('§f[ §4R§8C §f] Teleport request pending.')
#  }
# array_push(@tpahere, player())
# store_value(@target . '.tpahere', @tpahere)
# tmsg(player(), '§f[ §4R§8C §f] Bring here request sent to §o' . @target . '§r.')
# tmsg(@target, '§f[ §4R§8C §f] Bring request recieved from §o' . player() . '§r.\n§fType §7/tpaccept §fto accept. Type §7/tpdeny §fto deny.')
#<<<

*:/time $time [$] = >>>
 if(has_permission('refinecraft.time'))
  {
  #call_alias(/display player() '/time' $time $)
  if($time == 'day')
   {
   @time = '1'
   }
  else if($time == 'night')
   {
   @time = '13500'
   }
  else
   {
   @time = $time
   }
  sudo('/time set' $time)
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/unban [$target=''] [$] = >>>
 if(has_permission('refinecraft.unban'))
  {
  if($target == '')
   {
   die('§f[ §4R§8C §f] Usage: /unban <player>')
   }
  #call_alias(/display player() '/unban' $target $)
  sudo('/minecraft:pardon' $target)
  msg('§f[ §4R§8C §f] Player unbanned.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/unban-ip [$ip=''] [$] = >>>
 if (has_permission('refinecraft.unban-ip'))
  {
  if ($ip == '')
   {
   die('§f[ §4R§8C §f] Usage: /unban-ip <IP>')
   }
  #call_alias(/display player() '/unban-ip' $ip $)
  set_ip_banned($ip, false)
  msg('§f[ §4R§8C §f] IP Unbanned.')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/ver [$=''] = call_alias(/version $)
*:/version [$=''] = >>>
 if(has_permission('refinecraft.version'))
  {
  die('§fThis server is running RefineCraftAPI 1.9.0 - Build #16.03.02')
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/whois [$target=''] = >>>
 if (has_permission('refinecraft.cmds.whois'))
  {
  if ($target == '')
   {
   @target = player()
   }
  if ($target != '')
   {
   try(@target = player($target), die('§f[ §4R§8C §f] Player not found.'))
   }
  msg('§4Name:§8' pinfo(@target, 0))
  msg('§4Location:§8' pinfo(@target, 1))
  msg('§4Cursor Pos:§8' pinfo(@target, 2))
  msg('§4IP Address:§8' pinfo(@target, 3))
  msg('§4Display Name:§8' pinfo(@target, 4))
  msg('§4Health:§8' pinfo(@target, 5))
  msg('§4Item in Hand:§8' pinfo(@target, 6))
  msg('§4World:§8' pinfo(@target, 7))
  msg('§4OP:§8' pinfo(@target, 8))
  msg('§4Groups:§8' pinfo(@target, 9))
  msg('§4Hostname:§8' pinfo(@target, 10))
  msg('§4Sneaking:§8' pinfo(@target, 11))
  msg('§4Host:§8' pinfo(@target, 12))
  msg('§4Entity ID:§8' pinfo(@target, 13))
  msg('§4In Vehicle:§8' pinfo(@target, 14))
  msg('§4Hand Slot:§8' pinfo(@target, 15))
  msg('§4Sleeping:§8' pinfo(@target, 16))
  msg('§4Blocking:§8' pinfo(@target, 17))
  msg('§4Flying:§8' pinfo(@target, 18))
  msg('§4Sprinting:§8' pinfo(@target, 19))
  msg('§4UUID:§8' pinfo(@target, 20))
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

# Deprecated
#*:/workbench [$=''] = >>>
# if (has_permission('refinecraft.workbench'))
#  {
#  pworkbench(player())
#  }
# else
#  {
#  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not #Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
#  }
#<<<

*:/rc world [$arg1=''] [$arg2=''] [$arg3=''] [$arg4=''] [$arg5=''] [$] = >>>
 if(has_permission('refinecraft.world'))
  {
  if($arg1 == 'list')
   {
   msg(get_worlds());
   }
  if(($arg1 == create)&&($arg2 != '')&&($arg3 != '')&&($arg4 != ''))
   {
   create_world($arg2, $arg3, $arg4);
   }
  else if($arg1 == 'create')
   {
   msg('/rc world create <name> [type] [environment] [seed] [generator]')
   }
  if(($arg1 == unload)&&($arg2 != ''))
   {
   unload_world($arg2, true);
   }
  }
 else
  {
  die('§f[§6warn§f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[§3info§f] Available options found in /help§f');
  }
<<<

*:/arrowstorm [$rad=1] [$ex=1] [$target=''] [$=''] = >>>
 if (has_permission('refinecraft.mirv'))
  {
  if($target == '')
   {
   @target = player()
   }
  else
   {
   @target = player($target)
   }
  ##call_alias(/display player() '/mirv' $rad $ex @target $)
  @launch = ploc(@target)
  @drop = ploc(@target)
  @launch[y] = 255
  @drop[y] = 252
  @radius = $rad
  for(@i=0, @i < ($ex * 250), ++@i)
   {
   @deg = rand(0,360)
   @x = cos(@deg) * @radius * (rand(1,100) / 500)
   @z = sin(@deg) * @radius * (rand(1,100) / 500)
   @drop[x] = @launch[x] + @x
   @drop[z] = @launch[z] + @z
   spawn_entity('ARROW', 1, @drop)
   }
  for(@i=0, @i < 8, ++@i)
   {
   explosion(@launch, 15, true)
   }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<

*:/storm [$rad=1] [$ex=1] [$target=''] [$=''] = >>>
 if (has_permission('refinecraft.mirv'))
  {
  if($target == '')
   {
   @target = player()
   }
  else
   {
   @target = player($target)
   }
   ##call_alias(/display player() '/mirv' $rad $ex @target $)
   @launch = ploc(@target)
   @drop = ploc(@target)
   @launch[y] = 255
   @drop[y] = 252
   @radius = $rad
   for(@i=0, @i < ($ex * 250), ++@i)
    {
    @deg = rand(0,360)
    @x = cos(@deg) * @radius * (rand(1,100) / 500)
    @z = sin(@deg) * @radius * (rand(1,100) / 500)
    @drop[x] = @launch[x] + @x
    @drop[z] = @launch[z] + @z
    @entities = spawn_entity('SMALL_FIREBALL', 1, @drop)
    foreach(@entities, @e)
     {
     set_entity_velocity(@e, array(0, -50, 0))
     }
    }
   for(@i=0, @i < 8, ++@i)
    {
    #explosion(@launch, 15, true)
    }
  }
 else
  {
  die('§f[ §4R§8C §f] Error:  §cPermission Denied §for §cCommand Not Found§f\n§f[ §4R§8C §f] Available options found in /help§f')
  }
<<<
