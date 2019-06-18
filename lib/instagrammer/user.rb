# frozen_string_literal: true

class Instagrammer::User
  include Capybara::DSL

  attr_reader :name, :username, :avatar, :bio, :url, :follower_count

  def initialize(username)
    @username = username

    get_data
  end

  def get_data
    visit "https://www.instagram.com/#{@username}/"
    check_account_status

    node = page.first(:json_ld, visible: false)
    data = JSON.parse(node.text(:all))
    @name = data["name"]
    @username = data["name"]
    @avatar = data["image"]
    @bio = data["description"]
    @url = data["url"]
    @follower_count = data["mainEntityofPage"]["interactionStatistic"]["userInteractionCount"].to_i
  rescue Capybara::ExpectationNotMet
    raise Instagrammer::IncompleteBio.new("Incomplete bio: #{@username}")
  end

  private
    def check_account_status
      if page.has_content?("Private")
        raise Instagrammer::PrivateAccount.new("Private account: #{@username}")
      elsif page.has_content?("Sorry")
        raise Instagrammer::UserNotFound.new("User not found: #{@username}")
      end
    end
end
