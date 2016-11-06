# coding: utf-8
# frozen_string_literal: true

module SimpleServiceObject
  class Result
    attr_reader :errors, :value

    def initialize(value, errors = [])
      @value = value
      @errors = Array(errors)
    end

    def success?
      errors.empty?
    end

    def failure?
      !success?
    end
  end
end
