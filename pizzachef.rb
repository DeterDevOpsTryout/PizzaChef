#!/usr/bin/env ruby

require 'webrick'
require 'net/http'
require 'uri'

server = WEBrick::HTTPServer.new :Port => 8081

trap 'INT' do server.shutdown end

server.mount_proc '/pieRequest' do |req, res|
  cnt = req.query()['count']
  puts "%d pies requested" % cnt
  sleep(1)
  uri = URI.parse("http://woodbrick.deterlab.net:8082")
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new("/cook")
  response = http.request(request)
  puts "The oven says %s" % response.body
  sleep(1)
  res.body = cnt
end

server.start
