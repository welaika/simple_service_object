# coding: utf-8
# frozen_string_literal: true

require "spec_helper"

describe SimpleServiceObject do
  it "has a version number" do
    expect(SimpleServiceObject::VERSION).not_to be nil
  end
end
