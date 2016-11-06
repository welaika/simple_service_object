# coding: utf-8
# frozen_string_literal: true

require "spec_helper"

describe SimpleServiceObject::Result do
  describe "#value" do
    let(:result) { described_class.new(:foo) }
    it "returns the value" do
      expect(result.value).to eq(:foo)
    end
  end

  describe "#errors" do
    let(:result) { described_class.new(:foo, ["Error X"]) }
    it "returns the errors array" do
      expect(result.errors).to eq(["Error X"])
    end
  end

  context "when there are errors" do
    let(:result) { described_class.new(:foo, ["Error X"]) }

    describe "#success?" do
      it "returns `false`" do
        expect(result.success?).to be(false)
      end
    end

    describe "#failure?" do
      it "returns `true`" do
        expect(result.failure?).to be(true)
      end
    end
  end

  context "when there aren't errors" do
    let(:result) { described_class.new(:foo) }

    describe "#success?" do
      it "returns `true`" do
        expect(result.success?).to be(true)
      end
    end

    describe "#failure?" do
      it "returns `false`" do
        expect(result.failure?).to be(false)
      end
    end
  end
end
