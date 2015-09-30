#!/usr/bin/env ruby

require 'webrick'

server = WEBrick::HTTPServer.new :Port => 8081

trap 'INT' do server.shutdown end

server.mount_proc '/pieRequest' do |req, res|
  cnt = req.query()['count']
  puts "%d pies requested" % cnt
  sleep(4.7)
  res.body = cnt
end

server.start
