bind(player_chat, null, null, @event,
 @player = @event['player']
 @format = @event['format']
 @original_message = @event['message']
 @message = @original_message
 @count = 0

######## CAPS ########
 @pattern = '[A-Z]{10,120}'
 if(reg_count(@pattern, @message) > 0)
  {
  ++@count
  @message = to_lower(@message)
  }
 @message = to_lower(@message)
########################

######## SPAM ########
 assign(@patterns, array(
  '(?<!)(^[a-zA-Z]$)(?!)',
  '[a-zA-Z0-9]{20,250}'
  ))
 foreach(@patterns, @pattern)
  {
  if(reg_count(@pattern, @message) > 0)
   {
   ++@count
   @message = reg_replace(@pattern,'[SPAM]', @message)
   }
  }
########################

######## SWEAR ########
 assign(@patterns, array(
  '[a-zA-Z0-9]{0,25}((anus)|(anus))[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(ass)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(bastard)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(b[il1]tch)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(b[o0]n[e3]r)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(br[e3]ast)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(b[o0][o0]b)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(c[o0]ck)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(cum)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(cunt)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(d[il1]ck)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(d[il1]ld[o0])[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(d[o0]ng)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(d[o0]uch)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([e3]r[e3]ct)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([f(ph)]ag)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([f(ph)]ap)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([f(ph)]uck)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(ga[iy])[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(hump)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(j[il1]z)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(l[e3]sb)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(mast[eu]rb(ait|ate))[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(na[sz][il1])[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(n[il1]g)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(n[il1]p)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([o0]rg[iy])[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(p[e3]n[il1][s$])[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(p[il1][s$][s$])[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(p[o0]rn)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(pub[e3])[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(pu[s$][s$])[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(qu[e3][e3]r)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(rap[eil13])[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(tard)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([s$][e3](x|cks|ks))[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([s$](h)(a)(g))[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([s$]h[il1]t)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([s$]lut)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([s$](m)[e3]x)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}([s$](t)[il1]ff[iy])[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}((three|3)(some|sem))[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(t[il1]t)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(vag)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(wank)[a-zA-Z0-9]{0,25}',
  '[a-zA-Z0-9]{0,25}(h[o0]r[e3])[a-zA-Z0-9]{0,25}'
  ))
 foreach(@patterns, @pattern)
  {
  if(reg_count(@pattern, @message) > 0)
   {
   ++@count
   @message = reg_replace(@pattern,'[EXPLETIVE]', @message)
   }
  }
########################









 if(@count > 0)
  {
  sys_out(@player 'said' @original_message)
  }
 else
  {
  @message = @original_message
  }
 modify_event('message', @message)
 )
