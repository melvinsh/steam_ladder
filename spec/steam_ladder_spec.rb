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

  describe 'ladder' do
    it 'retrieves a Steam ladder by type' do
      ladder = @api.ladder('xp')

      expect(ladder.type).to eq('XP')
      expect(ladder.ladder).to be_an_instance_of(Array)
      expect(ladder.ladder.length).to eq(100)
      expect(ladder.country_code).to eq(nil)
    end

    it 'retrieves a Steam ladder by type and country' do
      ladder = @api.ladder('playtime', 'nl')

      expect(ladder.type).to eq('PT')
      expect(ladder.ladder).to be_an_instance_of(Array)
      expect(ladder.ladder.length).to eq(100)
      expect(ladder.country_code).to eq('NL')
    end

    it 'retrieves a Steam ladder by type and region' do
      ladder = @api.ladder('badges', 'europe')

      expect(ladder.type).to eq('B')
      expect(ladder.ladder).to be_an_instance_of(Array)
      expect(ladder.ladder.length).to eq(100)
      expect(ladder.country_code).to eq('EUROPE')
    end
  end
end
