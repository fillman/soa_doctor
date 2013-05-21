require "net/http"

module Healthcheck
  module Commands
    class StatusCheck < ::Escort::ActionCommand::Base
      def execute
        rows = []
        file = ::YAML.load_file(command_options[:file])
        file["services"].each_pair do |k, v|
          begin
            req = Thread.new(v) { |page|
              ::Net::HTTP.get_response(URI(page))
            }
            req = ::Net::HTTP.get_response(URI(v))
            rows << [k, req.code, req.message]

          rescue Exception => e
            rows << [k, { :value => e.inspect, :colspan => 2 }]
          end
        end

        ::Terminal::Table.new :headings => ['Service', 'Status', 'Message'], :rows => rows
      end
    end
  end
end