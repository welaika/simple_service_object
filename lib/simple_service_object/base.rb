# coding: utf-8
# frozen_string_literal: true

module SimpleServiceObject
  class Base
    def self.call(*args)
      instance = new(*args)
      result_value = instance.call
      Result.new(result_value, instance.errors)
    end

    def self.call!(*args)
      result = call(*args)
      raise FailureError, result.errors.join(", ") if result.failure?
      result.value
    end

    def call
      raise NotImplementedError, "Should be implemented in subclass."
    end

    def errors
      @errors ||= []
    end
  end
end
