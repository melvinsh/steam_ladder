# `steam_ladder`
<b>Ruby wrapper for the <a href="https://steamladder.com/">Steam Ladder</a> API</b>.

[![Build Status](https://app.travis-ci.com/melvinsh/steam_ladder.svg?branch=main)](https://app.travis-ci.com/melvinsh/steam_ladder)  [![Gem Version](https://badge.fury.io/rb/steam_ladder.svg)](https://badge.fury.io/rb/steam_ladder)  [![Coverage Status](https://coveralls.io/repos/github/melvinsh/steamladder.js/badge.svg?branch=master)](https://coveralls.io/github/melvinsh/steamladder.js?branch=master)

## Usage examples
### Initialization
``` ruby
@api = SteamLadder.new('API_KEY')
```

### Getting a profile
``` ruby
@api.profile('76561198029517073')
``` 

Will return an object like the one below (many attributes removed to reduce the amount of lines):

``` ruby
OpenStruct {
  :steam_user => OpenStruct {
    :steam_name => "Melvin",
    :steam_id => "76561198029517073",
    :steamladder_url => "https://steamladder.com/profile/76561198029517073/",
    :steam_join_date => "2010-08-25T18:20:11",
    :steam_country_code => "NL",
    :is_steam_private => false
  },

  :steam_ladder_info => OpenStruct {
    :is_staff => false,
    :is_winter_18 => false,
    :is_winter_19 => false,
    :is_donator => false,
    :is_top_donator => false,
    :patreon_tier => "Platinum"
  },

  :steam_stats => OpenStruct {
    :last_update => "2021-08-17T19:54:03.800318",
    :level => 151,
    :xp => 122052,
    :friends => 211,
    :badges => OpenStruct {
      :total => 337
    }
  }
}
```

Objects can be accessed like:

``` ruby
profile.steam_user.steam_id == '76561198029517073'
profile.steam_user.steam_join_date == '2010-08-25T18:20:11'
profile.steam_stats.badges.total == 337
```

