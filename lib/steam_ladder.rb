# frozen_string_literal: true

require 'http'

class SteamLadder
  def initialize(key, url = 'https://steamladder.com/api/v1')
    @key = key
    @url = url
  end

  def profile(steam_id_64)
    json = http_get("#{@url}/profile/#{steam_id_64}/")
    JSON.parse(json, object_class: OpenStruct)
  end

  def update_profile(steam_id_64)
    json = http_post("#{@url}/profile/#{steam_id_64}/")
    response = JSON.parse(json, object_class: OpenStruct)

    if response.error
      OpenStruct.new(
        success: false,
        error: response.error,
        last_update: response.last_update
      )
    else
      OpenStruct.new(
        success: true,
        last_update: response.steam_stats.last_update
      )
    end
  end

  def ladder(type, country = nil)
    url = "#{@url}/ladder/#{type}/"
    url += "#{country}/" if country

    json = http_get(url)
    JSON.parse(json, object_class: OpenStruct)
  end

  private

  def http_get(url)
    HTTP.headers(authorization: "Token #{@key}")
        .get(url)
  end

  def http_post(url)
    HTTP.headers(authorization: "Token #{@key}")
        .post(url)
  end
end
