# frozen_string_literal: true

require "spec_helper"

describe SimpleServiceObject do
  it "has a version number" do
    expect(SimpleServiceObject::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
