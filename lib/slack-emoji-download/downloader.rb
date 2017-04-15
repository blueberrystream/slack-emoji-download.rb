require 'open-uri'
require 'ruby-progressbar'
require 'json'

module SlackEmojiDownload
  class SlackApiError < RuntimeError; end
  class Downloader
    class << self
      def get_emoji_list(token)
        uri = "https://slack.com/api/emoji.list?token=#{token}"
        response = OpenURI.open_uri(uri).read
        response = JSON.parse response

        unless response['ok']
          raise SlackApiError.new response['error']
        end

        response['emoji']
      end

      def download_emoji(list, dest)
        puts
        progress_bar = ProgressBar.create(
          title: 'Downloading',
          total: list.count,
          format: '%t |%B| %J%%(%c/%C) %a %E'
        )
        list.each do |key, uri|
          unless uri.start_with? 'alias'
            ext = File.extname uri
            File.binwrite dest + '/' + key + ext, OpenURI.open_uri(uri).read
            progress_bar.increment
          end
        end
        progress_bar.finish
      end
    end
  end
end
