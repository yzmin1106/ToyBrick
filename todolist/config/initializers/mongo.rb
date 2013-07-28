MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = 'todo' #为了简单起见，没有为不同的环境指定不同的数据

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end
