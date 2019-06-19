# frozen_string_literal: true

class Instagrammer::User
  include Capybara::DSL

  def initialize(username)
    @username = username
  end

  def valid?
    get_data unless @data
    @status == :valid
  end

  def data
    get_data unless @data

    case @status
    when :private then raise Instagrammer::PrivateAccount.new("Private account: #{@username}")
    when :not_found then raise Instagrammer::UserNotFound.new("User not found: #{@username}")
    when :invalid then raise Instagrammer::UserInvalid.new("User invalid: #{@username}")
    else @data
    end
  end

  def name
    data["name"]
  end

  def username
    data["name"]
  end

  def avatar
    data["image"]
  end

  def bio
    data["description"]
  end

  def url
    data["url"]
  end

  def follower_count
    data["mainEntityofPage"]["interactionStatistic"]["userInteractionCount"].to_i
  end

  private
    def get_data
      visit "https://www.instagram.com/#{@username}/"
      @status = get_account_status

      if @status == :valid
        node = page.first(:json_ld, visible: false)
        @data = JSON.parse(node.text(:all))
      end
    end

    def get_account_status
      if page.has_content?("Private")
        :private
      elsif page.has_content?("Sorry")
        :not_found
      elsif page.find(:json_ld, visible: false)
        :valid
      end
    rescue Capybara::ElementNotFound
      :invalid
    end
end
