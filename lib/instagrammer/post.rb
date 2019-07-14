# frozen_string_literal: true

class Instagrammer::Post
  include Capybara::DSL
  include Instagrammer::Utils

  attr_reader :shortcode, :image_url, :image_urls

  def initialize(shortcode)
    @shortcode = shortcode
    @data = nil
  end

  def public?
    get_data unless @data
    @status == :public
  end

  def data
    get_data unless @data

    case @status
    when :private then raise Instagrammer::PrivatePost.new("Private post: #{@shortcode}")
    when :not_found then raise Instagrammer::PostNotFound.new("Post not found: #{@shortcode}")
    when :invalid then raise Instagrammer::PostInvalid.new("Post invalid: #{@shortcode}")
    else @data
    end
  end

  def type
    data["@type"] == "ImageObject" ? :photo : :video
  end

  def photo?
    type == :photo
  end

  def video?
    type == :video
  end

  def user
    Instagrammer::User.new data["author"]["alternateName"]
  end

  def caption
    data["caption"]
  end

  def upload_date
    DateTime.parse data["uploadDate"]
  end

  def comment_count
    data["commentCount"].to_i
  end

  def like_count
    data["interactionStatistic"]["userInteractionCount"].to_i if photo?
  end

  def watch_count
    data["interactionStatistic"]["userInteractionCount"].to_i if video?
  end

  private
    def get_data
      visit "https://www.instagram.com/p/#{@shortcode}/"
      @status = get_page_status

      if @status == :public
        node = page.first(:json_ld, visible: false)
        @data = JSON.parse(node.text(:all))
        set_image_attributes if photo?
      end
    end

    IMAGE_URLS_RE = /(\S+) (\d+)w/
    def set_image_attributes
      node = page.find(:image)
      @image_url = node["src"]
      @image_urls = node["srcset"].scan(IMAGE_URLS_RE).collect do |match|
        {
          url: match[0],
          width: match[1].to_i
        }
      end
    end
end
