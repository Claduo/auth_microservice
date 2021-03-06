module RabbitMq
  extend self
  @mutex = Mutex.new

  def connection
    @mutex.synchronize do
      @connection ||= Bunny.new(
          host: Settings.rabbitmq.host,
          username: Settings.rabbitmq.username,
          password: Settings.rabbitmq.password
      ).start
    end
  end

  def channel
    Thread.current[:rabbit_channel] ||= connection.create_channel
  end

  def consumer_chanel
    Thread.current[:rabbit_consumer_channel] ||=
        connection.create_channel(nil, Settings.rabbitmq.consumer_pool)
  end
end