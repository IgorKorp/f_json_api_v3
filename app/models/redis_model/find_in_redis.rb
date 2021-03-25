module RedisModel
  module FindInRedis

    def get_model_name
      "#{self.name.downcase}s".to_sym
    end

    def find(uuid)
      model_hash = REDIS.hgetall(uuid)
      self.new(args: model_hash)
    end

    def get_all_uuid(from: 0, to: -1)
      if from == 0 && to == -1
        return  REDIS.zrange(get_model_name.to_s, from.to_i, to.to_i)
      end
      REDIS.zrangebyscore(get_model_name.to_s, from, to)
    end

    def get_all_models(from: 0, to: -1)
      list_uuid_models = get_all_uuid(from: from, to: to)
      models = []
      list_uuid_models.each do |uuid|
        models << find(uuid)
      end
      models
    end

  end
end