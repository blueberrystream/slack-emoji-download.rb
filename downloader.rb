#!/bin/env ruby

require 'open-uri'
require 'JSON'

team = ARGV[0]
dest_dir = team
Dir.mkdir dest_dir unless Dir.exist? dest_dir

json = File.open("#{team}.json").read
json = JSON.parse json
json['emoji'].each do |key, url|
  unless url.start_with? 'alias'
    puts key

    ext = File.extname url
    File.binwrite dest_dir + '/' + key + ext, OpenURI.open_uri(url).read
  end
end
