require "http/client"
require "http/web_socket"
require "json"

web_socket = HTTP::WebSocket.new("wss://ws-api.coincheck.com")
web_socket.on_message do |msg|
  puts "Message: #{msg}"
end

web_socket.on_close do
  puts "Socket has been closed..."
  exit -1
end

puts "Start running websocket..."

spawn do
  puts "Before subscribing <-"

  while web_socket.closed?; end

  puts "Socked opened"

  web_socket.send({ type: "subscribe", channel: "btc_jpy-trades" }.to_json)
  web_socket.send({ type: "subscribe", channel: "btc_jpy-orderbook" }.to_json)

  puts "Subscribed"
end

web_socket.run
puts "come here"
