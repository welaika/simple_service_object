# coding: utf-8
# frozen_string_literal: true

require "spec_helper"

describe SimpleServiceObject::Base do
  describe ".call" do
    context "arguments handover" do
      before do
        stub_const("MyService", Class.new(SimpleServiceObject::Base)).class_eval do
          def initialize(args); end

          def call; end
        end
      end

      let(:instance) { instance_double("MyService").as_null_object }

      it "initialize a new object with arguments and call `#call`" do
        expect(MyService).to receive(:new).with([:foo, :bar]).and_return(instance)
        expect(instance).to receive(:call)
        expect(MyService.call([:foo, :bar]))
      end
    end

    context "when subclass does not define `#call` method" do
      before do
        stub_const("MyService", Class.new(SimpleServiceObject::Base))
      end
      it "raises a NotImplementedError" do
        expect { MyService.call }.to raise_exception(NotImplementedError)
      end
    end

    context "when there aren't any errors" do
      before do
        stub_const("MyService", Class.new(SimpleServiceObject::Base)).class_eval do
          def call
            "foobar"
          end
        end
      end

      it "returns a result object" do
        result = MyService.call
        expect(result.value).to eq("foobar")
        expect(result.errors).to be_empty
        expect(result).to be_success
        expect(result).to_not be_failure
      end
    end

    context "when there are errors" do
      before do
        stub_const("MyService", Class.new(SimpleServiceObject::Base)).class_eval do
          def call
            errors.push("Oh my gosh!")
            "foobar"
          end
        end
      end

      it "returns a result object" do
        result = MyService.call
        expect(result.value).to eq("foobar")
        expect(result.errors).to eq(["Oh my gosh!"])
        expect(result).to_not be_success
        expect(result).to be_failure
      end
    end
  end

  describe ".call!" do
    context "when there aren't any errors" do
      before do
        stub_const("MyService", Class.new(SimpleServiceObject::Base)).class_eval do
          def call
            "foobar"
          end
        end
      end

      it "returns result value" do
        expect(MyService.call!).to eq("foobar")
      end
    end

    context "when there are errors" do
      before do
        stub_const("MyService", Class.new(SimpleServiceObject::Base)).class_eval do
          def call
            errors.push("Oh my gosh!")
          end
        end
      end

      it "raises an exception" do
        expect { MyService.call! }.to(
          raise_exception(SimpleServiceObject::FailureError, /Oh my gosh/)
        )
      end
    end
  end
end
