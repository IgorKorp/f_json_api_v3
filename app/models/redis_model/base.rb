require 'securerandom'
require 'json'
require 'redis'

module RedisModel

  class Base

    include ActiveModel::Serializers::JSON
    extend FindInRedis
    @@properties = Hash.new{|h,k| h[k] = []}
    attr_accessor :uuid, :created_at

    def initialize(args: {})
      self.create args

      if @created_at.nil?
        self.created_at = Time.new.to_i
      end
      if @uuid.nil?
        self.uuid= SecureRandom.uuid
      end
    end

    class << self
      def property(property_name)
        @@properties[get_model_name] << property_name

        define_method(property_name)  do
          instance_variable_get("@#{property_name}")
        end

        define_method("#{property_name}=") do |v|
          instance_variable_set("@#{property_name}", v)
        end
      end

      def created(args: {})
        self.new(args: args).save
      end
    end

    def to_h
      hash = {}
      self.get_property_model do |key, value|
        hash[key] = value
      end
      hash
    end

    def attributes=(hash)
      hash.each do |key, value|
        send("#{key}=", value)
      end
    end

    def attributes
      instance_values
    end

    def get_property_model(&blk)
      raise ArgumentError, 'you must add block' if blk.nil?
      self.properties.each do |key|
        if self.class.method_defined?(key)
          blk.call(key, send(key))
        end
      end
    end

    def properties
      @@properties[self.class.get_model_name]
    end

    def create(args = {})
      args.each do |key, value|
        if self.class.method_defined?("#{key}=".to_sym)
          send("#{key}=", value)
        end
      end
    end

    def save
      REDIS.multi
        REDIS.zadd(self.class.get_model_name.to_s, self.created_at, self.uuid)
        REDIS.hset(self.uuid, self.to_h)
      REDIS.exec ? self : false
    end

  end
end
