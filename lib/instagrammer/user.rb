# frozen_string_literal: true

module Instagrammer
  class User
    include Capybara::DSL

    attr_reader :name, :username, :avatar, :bio, :url, :follower_count

    def initialize(username)
      @username = username

      get_data
    end

    def get_data
      visit "https://www.instagram.com/#{@username}/"
      raise UserNotFound.new("User not found: #{@username}") if page.title.include?("Page Not Found")

      node = page.first(:xpath, ".//script[@type='application/ld+json']", visible: false)
      data = JSON.parse(node.text(:all))
      @name = data["name"]
      @username = data["name"]
      @avatar = data["image"]
      @bio = data["description"]
      @url = data["url"]
      @follower_count = data["mainEntityofPage"]["interactionStatistic"]["userInteractionCount"]
    end
  end
end
