require 'spec_helper'

describe SoaDoctor::Commands::StatusCheck do


  let(:options)   { { :global => { :options => { :file => File.expand_path("../../../example/services.yml", __FILE__) } } } }
  let(:arguments) { [] }

  it "should have execute method" do
    described_class.instance_methods.include?(:execute).should be_true
  end

  it "should ping each service and display results" do
    stub_request(:any, /.*/).to_return(:status => [200, "Doc I'm OK!"])
    described_class.new(options, arguments).execute.render.should == <<-EOF.deindent
        +---------+--------+-------------+
        | Service | Status | Message     |
        +---------+--------+-------------+
        | google  | 200    | Doc I'm OK! |
        | yahoo   | 200    | Doc I'm OK! |
        | yandex  | 200    | Doc I'm OK! |
        +---------+--------+-------------+
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