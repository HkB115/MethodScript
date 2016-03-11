##### CHAT INTERFACE #####
bind(player_chat, null, null, @event,
 @format = @event['format'];
 @message = @event['message'];
 @player = @event['player'];
 @recipients = @event['recipients'];
 @channel = get_value(@player.'.channel');
 if(@channel == null)
  {
  @channel = 'global';
  }
 @parsed = array();
 @parsed = parse_args(@message);
 @mod = substr(@parsed[0], 0, 1);
 @arg = substr(@parsed[0], 1);
 if(@mod == '@')
  {
  @channel = 'private';
  @res = res_create_resource('STRING_BUILDER');
  for(@i = 1, @i < array_size(@parsed), ++@i)
   {
   string_append(@res, @parsed[@i], ' ');
   }
  @message = string(@res);
  res_free_resource(@res);
  try(@target = player(@arg), die('§f[ §4R§8C §f] Player not found.'));
  store_value(@player.'.messaging', @target);
  store_value(@target.'.messaging', @player);
  tmsg(@player, '§f[ §4R§8C §f] You are now messaging§o' @target.'§r.');
  }
 if(@mod == '#')
  {
  if((@arg == 'global')&&(has_permission(@player, 'refinecraft.chat.channel.global')))
   {
   @channel = 'global';
   @res = res_create_resource('STRING_BUILDER');
   for(@i = 1, @i < array_size(@parsed), ++@i)
    {
    string_append(@res, @parsed[@i], ' ');
    }
   @message = string(@res);
   res_free_resource(@res);
   tmsg(@player, '§f[ §4R§8C §f] You are now in the Global channel.');
   }
  if((@arg == 'local')&&(has_permission(@player, 'refinecraft.chat.channel.local')))
   {
   @channel = 'local';
   @res = res_create_resource('STRING_BUILDER');
   for(@i = 1, @i < array_size(@parsed), ++@i)
    {
    string_append(@res, @parsed[@i], ' ');
    }
   @message = string(@res);
   res_free_resource(@res);
   tmsg(@player, '§f[ §4R§8C §f] You are now in the Local channel.');
   }
  if((@arg == 'staff')&&(has_permission(@player, 'refinecraft.chat.channel.staff')))
   {
   @channel = 'staff';
   @res = res_create_resource('STRING_BUILDER');
   for(@i = 1, @i < array_size(@parsed), ++@i)
    {
    string_append(@res, @parsed[@i], ' ');
    }
   @message = string(@res);
   res_free_resource(@res);
   tmsg(@player, '§f[ §4R§8C §f] You are now in the Staff channel.');
   }
  }
 store_value(@player.'.channel', @channel);
 ##### CHAT CHANNELS #####
 if(@channel == 'global')
  {
  @format = '§r<§f%1$s§r> §r%2$s';
  @recipients = all_players();
  }
 if(@channel == 'local')
  {
  @format = '§9<§f%1$s§9> §r%2$s';
  @recipients = array();
  foreach(all_players(), @other)
   {
   if(has_permission(@other, 'refinecraft.chat.channel.local'))
    {
    array_push(@recipients, @other);
    }
   }
  }
 if(@channel == 'private')
  {
  @format = '§8(§f%1$s§8) §r%2$s';
  @target = get_value(@player.'.messaging');
  @recipients = array(@player, @target);
  }
 if(@channel == 'staff')
  {
  @format = '§4<§f%1$s§4> §r%2$s';
  @recipients = array();
  foreach(all_players(), @other)
   {
   if(has_permission(@other, 'refinecraft.chat.channel.staff'))
    {
    array_push(@recipients, @other);
    }
   }
  }
 modify_event('format', @format);
 modify_event('message', @message);
 modify_event('recipients', @recipients);
 )
 
