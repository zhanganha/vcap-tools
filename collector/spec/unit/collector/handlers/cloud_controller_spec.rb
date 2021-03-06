require "spec_helper"

describe Collector::Handler::CloudController do
  let(:now) { Time.now }
  let(:data) { {} }
  let(:historian) do
    Object.new.tap do |historian|
      historian.stub(:send_data) do |send_data|
        data[send_data[:key]] = send_data
      end
    end
  end
  let(:context) { Collector::HandlerContext.new(0, now, fixture(:cloud_controller)) }
  let(:handler) { Collector::Handler::CloudController.new(historian, "CloudController") }

  it "should register itself as a handler" do
    Collector::Handler.handler_map.clear
    silence_warnings do
      load "collector/handlers/cloud_controller.rb" # Must re-register
    end
    handler
    Collector::Handler.handler_map["CloudController"].should == handler.class
  end

  describe "process" do
    subject do
      handler.process(context)
      data
    end

    its(["cc.requests.outstanding"]) { should eq(
      key: "cc.requests.outstanding",
      timestamp: now,
      value: 22,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}

    its(["cc.requests.completed"]) { should eq(
      key: "cc.requests.completed",
      timestamp: now,
      value: 9828,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}

    its(["cc.db.pool.size"]) { should eq(
      key: "cc.db.pool.size",
      timestamp: now,
      value: 17,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}

    its(["cc.db.pool.max_size"]) { should eq(
      key: "cc.db.pool.max_size",
      timestamp: now,
      value: 32,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}

    its(["cc.db.pool.allocated"]) { should eq(
      key: "cc.db.pool.allocated",
      timestamp: now,
      value: 5,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}

    its(["cc.db.pool.available"]) { should eq(
      key: "cc.db.pool.available",
      timestamp: now,
      value: 12,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}

    its(["cc.http_status.1XX"]) { should eq(
      key: "cc.http_status.1XX",
      timestamp: now,
      value: 3,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}

    its(["cc.http_status.2XX"]) { should eq(
      key: "cc.http_status.2XX",
      timestamp: now,
      value: 9105 + 203,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}


    its(["cc.http_status.3XX"]) { should eq(
      key: "cc.http_status.3XX",
      timestamp: now,
      value: 12 + 21,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}

    its(["cc.http_status.4XX"]) { should eq(
      key: "cc.http_status.4XX",
      timestamp: now,
      value: 622 + 99 + 2,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}

    its(["cc.http_status.5XX"]) { should eq(
      key: "cc.http_status.5XX",
      timestamp: now,
      value: 22,
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}

    its(["cc.uptime"]) { should eq(
      key: "cc.uptime",
      timestamp: now,
      value: 2 + (60 * 2) + (60 * 60 * 2) + (60 * 60 * 24 * 2),
      tags: {
        role: "core",
        job: "CloudController",
        index: 0,
        name: "CloudController/0",
        deployment: "untitled_dev"
      }
    )}
  end
end