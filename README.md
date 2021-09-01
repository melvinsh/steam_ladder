# `steam_ladder`
<b>Ruby wrapper for the <a href="https://steamladder.com/">Steam Ladder</a> API</b>.

[![Build Status](https://app.travis-ci.com/melvinsh/steam_ladder.svg?branch=main)](https://app.travis-ci.com/melvinsh/steam_ladder)  [![Gem Version](https://badge.fury.io/rb/steam_ladder.svg)](https://badge.fury.io/rb/steam_ladder)  [![Coverage Status](https://coveralls.io/repos/github/melvinsh/steam_ladder/badge.svg?branch=main)](https://coveralls.io/github/melvinsh/steam_ladder?branch=main)

## <a name='Tableofcontents'></a>Table of contents

<!-- vscode-markdown-toc -->
* [Installation](#Installation)
* [Usage examples](#Usageexamples)
	* [Initialization](#Initialization)
	* [Getting a profile](#Gettingaprofile)
	* [Updating a profile](#Updatingaprofile)
	* [Getting a ladder](#Gettingaladder)
		* [Normal request](#Normalrequest)
		* [Specifying a region or country](#Specifyingaregionorcountry)

<!-- vscode-markdown-toc-config
	numbering=false
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

## <a name='Installation'></a>Installation
Add this line to your application's Gemfile:
```ruby
gem 'steam_ladder', '~> 0.3.0'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install steam_ladder
```

Inside of your Ruby program do:
```ruby
require 'steam_ladder'
```

## <a name='Usageexamples'></a>Usage examples
### <a name='Initialization'></a>Initialization
``` ruby
@steam_ladder = SteamLadder.new('API_KEY')
```

### <a name='Gettingaprofile'></a>Getting a profile
``` ruby
profile = @steam_ladder.profile('76561198029517073')
``` 

Will return an object like the one below (with many more attributes that have been removed from this example).

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
profile.steam_user.steam_id         # '76561198029517073'
profile.steam_user.steam_join_date  # '2010-08-25T18:20:11'
profile.steam_stats.badges.total    # 337
```

### <a name='Updatingaprofile'></a>Updating a profile
``` ruby
update = @steam_ladder.update_profile('76561198029517073')
``` 

Returns an object with a `success` attribute that can be either `true` or `false`.
If the update fails (usually due to the limit - once every four hours), the `error` attribute can be accessed.

The `last_update` attribute indicates the last update time.

Example implementation:

``` ruby
update = @api.update_profile('76561197996764410')

if update.success
  puts "Yay! We did it."
else
  puts "Oh no, something went wrong: #{update.error}"
  puts "Last update was at #{update.last_update}, so maybe we went too fast."
end
```

### <a name='Gettingaladder'></a>Getting a ladder
#### <a name='Normalrequest'></a>Normal request
``` ruby
# Available types: xp, games, playtime, badges, steam_age, vac, game_ban
ladder = @steam_ladder.ladder('xp')
``` 

#### <a name='Specifyingaregionorcountry'></a>Specifying a region or country
``` ruby
# Available country codes: alpha-2 country codes (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
# Available regions: europe, north_america, south_america, asia, africa, oceania, antarctica

ladder = @steam_ladder.ladder('xp', 'nl')
ladder = @steam_ladder.ladder('games', 'europe')
``` 

Will return an object like the one below.

``` ruby
OpenStruct {
            :type => "XP",
        :type_url => "xp",
    :country_code => nil,
          :ladder => []
}
```

The `ladder` contains a maximum of `100` users and their position. Example user:

``` ruby
OpenStruct {
    :pos => 0,
    :steam_user => OpenStruct {
      :steam_name => "St4ck",
      :steam_id => "76561198023414915",
      :steamladder_url => "https://steamladder.com/profile/76561198023414915/",
      :steam_join_date => "2010-04-03T19:44:07",
      :steam_country_code => nil,
      :steam_avatar_src => "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/c4/c4cad1abe3a53c25e26a827655804bf754fbbe76_full.jpg"
    },
    :steam_stats => OpenStruct {
      :level => 5000,
      :xp => 125282351,
      :badges => OpenStruct {},
      :games => OpenStruct {},
      :bans => OpenStruct {}
    }
}    
```

So if we want the Steam name of the user in the 4th place:

``` ruby
ladder = @steam_ladder.ladder('xp')
ladder[3].steam_user.steam_name # "K-miK"
```

