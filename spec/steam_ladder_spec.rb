# frozen_string_literal: true

require_relative '../lib/steam_ladder'

describe SteamLadder do
  before do
    @api = SteamLadder.new(ENV['API_KEY'])
  end

  describe 'profile' do
    it 'retrieves a Steam Ladder profile' do
      profile = @api.profile('76561198029517073')

      expect(profile.steam_user.steam_id).to eq('76561198029517073')
      expect(profile.steam_user.steam_join_date).to eq('2010-08-25T18:20:11')
    end
  end
end
