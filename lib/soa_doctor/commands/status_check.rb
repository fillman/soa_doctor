require "net/http"

module SoaDoctor
  module Commands
    class StatusCheck < ::Escort::ActionCommand::Base
      def execute
        rows = []
        file = ::YAML.load_file(command_options[:file])
        file["services"].each_pair do |k, v|
            Thread.new(v) { |page|
              begin
                req = ::Net::HTTP.get_response(URI(page))
                rows << [k, req.code, req.message]
              rescue Exception => e
                rows << [k, { :value => e.inspect, :colspan => 2 }]
              end

              clear!
              puts ::Terminal::Table.new(:headings => ['Service', 'Status', 'Message'], :rows => rows)
            }.join
        end

        clear!
        ::Terminal::Table.new(:headings => ['Service', 'Status', 'Message'], :rows => rows)
      end

      def clear!
        # Clear screen, OMG! Any other way to do it?
        puts "\e[H\e[2J"
      end
    end
  end
end