# frozen_string_literal: true

require 'dotenv/load'
require 'http'

class SteamLadder
  def initialize(key, url = 'https://steamladder.com/api/v1')
    @key = key
    @url = url
  end

  def profile(steam_id_64)
    json = http_get(@url + '/profile/' + steam_id_64 + '/')
    JSON.parse(json, object_class: OpenStruct)
  end

  private

  def http_get(url)
    HTTP[:authorization => "Token #{@key}"].get(url)
  end
end
