# frozen_string_literal: true

class Instagrammer::User
  include Capybara::DSL

  attr_reader :posts

  def initialize(username)
    @username = username.delete_prefix("@")
    @posts = []
  end

  def inspect
    attributes = %i(follower_count following_count post_count name username avatar bio url posts)
    "#<#{self.class.name}:#{object_id} #{attributes.map { |attr| "#{attr}:#{send(attr).inspect}" }.join(", ")}>"
  end

  def public?
    get_data unless @data
    @status == :public
  end

  def meta
    get_data unless @data

    if @status == :not_found
      raise Instagrammer::UserNotFound.new("Private account: #{@username}")
    else
      @meta
    end
  end

  def follower_count
    meta[:followers]
  end

  def following_count
    meta[:following]
  end

  def post_count
    meta[:posts]
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
    data["alternateName"].delete_prefix("@")
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

  SHORTCODE_RE = /\/p\/(\S+)\/$/
  def get_posts(limit)
    shortcodes = []
    i = 0

    visit "https://www.instagram.com/#{@username}/"
    while i < limit
      post_links = page.all(:post_link)

      if limit > post_links.size
        page.execute_script "window.scrollTo(0,document.body.scrollHeight);"
        post_links = page.all(:post_link)
      end

      shortcode = post_links[i]["href"].match(SHORTCODE_RE)[1]
      shortcodes << shortcode
      i += 1
    end

    @posts = shortcodes.collect { |code| Instagrammer::Post.new(code) }
  end

  private
    def get_data
      visit "https://www.instagram.com/#{@username}/"
      @status = get_account_status
      @meta = get_metadata unless @status == :not_found

      if @status == :public
        node = page.first(:json_ld, visible: false)
        @data = JSON.parse(node.text(:all))
      end
    end

    META_RE = /(?<followers>\S+) Followers, (?<following>\S+) Following, (?<posts>\S+) Posts/
    def get_metadata
      @meta = page.first(:meta_description, visible: false)["content"].match META_RE
    end

    def get_account_status
      if page.has_content?("Private")
        :private
      elsif page.has_content?("Sorry")
        :not_found
      elsif page.find(:json_ld, visible: false)
        :public
      end
    rescue Capybara::ElementNotFound
      :invalid
    end
end
