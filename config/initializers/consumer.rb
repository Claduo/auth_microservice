channel = RabbitMq.consumer_chanel
exchange = channel.default_exchange
queue = channel.queue('auth', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON.parse(payload)

  decoded_token = JwtEncoder.decode(payload['token']) rescue {}
  result = Auths::AuthenticationService.call(decoded_token['uuid'])

  user_id = result.success? ? result.user.id : nil
  responce_payload = { user_id: user_id }.to_json

  exchange.publish(
      responce_payload,
      routing_key: properties.reply_to,
      correlation_id: properties[:correlation_id]
  )

  channel.ack(delivery_info.delivery_tag)
end