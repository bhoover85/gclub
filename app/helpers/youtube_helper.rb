module YoutubeHelper
  require 'rubygems'
  require 'google/api_client'
  require 'trollop'

  DEVELOPER_KEY = ENV["GOOGLE_API"]
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  def get_service
    client = Google::APIClient.new(
      :key => DEVELOPER_KEY,
      :authorization => nil,
      :application_name => "Great Games Club",
      :application_version => '1.0.0'
    )
    youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

    return client, youtube
  end

  def get_youtube_videos(name, platform)
    opts = Trollop::options do
      opt :q, 'Search term', :type => String, :default => "#{name} #{platform}"
      opt :max_results, 'Max results', :type => :int, :default => 1
      opt :order, 'Order', :type => String, :default => "viewCount"
      opt :regionCode, 'Region code', :type => String, :default => "US"
    end

    client, youtube = get_service

    begin
      # Call the search.list method to retrieve results matching the specified
      # query term.
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => opts[:q],
          :maxResults => opts[:max_results],
          :order => opts[:order],
          :regionCode => opts[:regionCode]
        }
      )

      videos = Hash.new
      channels = []
      playlists = []

      # Add each result to the appropriate list, and then display the lists of
      # matching videos, channels, and playlists.
      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
            # videos << "#{search_result.snippet.title} (#{search_result.id.videoId})"
            videos[search_result.snippet.title] = search_result.id.videoId
          when 'youtube#channel'
            channels << "#{search_result.snippet.title} (#{search_result.id.channelId})"
          when 'youtube#playlist'
            playlists << "#{search_result.snippet.title} (#{search_result.id.playlistId})"
        end
      end

    rescue Google::APIClient::TransmissionError => e
      puts e.result.body
    end

    return videos
  end

end
