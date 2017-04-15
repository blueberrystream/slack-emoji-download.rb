require 'thor'

module SlackEmojiDownload
  class CLI < Thor
    include Thor::Actions

    default_command :download

    desc 'download', 'download slack custom emoji.'
    option :token, required: true, type: :string, aliases: '-t', desc: 'Slack API Token'
    option :dest, type: :string, default: 'emoji', aliases: '-d', desc: 'direcotry for the dowload destination'
    def download
      return unless create_dest options[:dest]

      list = SlackEmojiDownload::Downloader::get_emoji_list options[:token]
      SlackEmojiDownload::Downloader::download_emoji list, options[:dest]
    rescue OpenURI::HTTPError
      say 'Can not to access the Slack API', :red
    rescue SlackApiError => e
      say 'Failed to call the Slack API.', :red
      say 'See the below messages from Slack API.', :red
      say e.message, :red
    end

    private

    def create_dest(path)
      if FileTest.exist? path
        say "Already exist: #{path}", :red

        if FileTest.directory? path
          return yes? 'Overwrite files in this directory? (y/N)'
        else
          say 'However this path is not a direcotry.', :red
          say 'Please specify the destination directory path to use --dest option.'
          return false
        end
      else
        empty_directory path, verbose: false
      end

      true
    end
  end
end
