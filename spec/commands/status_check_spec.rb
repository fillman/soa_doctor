require 'spec_helper'

describe Healthcheck::Commands::StatusCheck do


  let(:options)   { { :global => { :options => { :file => File.expand_path("../../../example/services.yml", __FILE__) } } } }
  let(:arguments) { [] }

  it "should have execute method" do
    described_class.instance_methods.include?(:execute).should be_true
  end

  it "should ping each service and display results" do
    stub_request(:any, /.*/).to_return(:status => [200, "It's fuckin' OK there!"])
    described_class.new(options, arguments).execute.render.should == <<-EOF.deindent
        +---------+--------+------------------------+
        | Service | Status | Message                |
        +---------+--------+------------------------+
        | google  | 200    | It's fuckin' OK there! |
        | yahoo   | 200    | It's fuckin' OK there! |
        | yandex  | 200    | It's fuckin' OK there! |
        +---------+--------+------------------------+
    EOF
  end

  it "should handle timeout" do
    stub_request(:any, /.*/).to_timeout
    described_class.new(options, arguments).execute.render.should == <<-EOF.deindent
         +---------+-------------------+-------------------+
         | Service | Status            | Message           |
         +---------+-------------------+-------------------+
         | google  | #<Timeout::Error: execution expired>  |
         | yahoo   | #<Timeout::Error: execution expired>  |
         | yandex  | #<Timeout::Error: execution expired>  |
         +---------+-------------------+-------------------+
    EOF
  end
end