require 'slop'

module JenkinsPivotalReleaseNotes
  class Cli
    attr_reader :options

    def initialize(items = ARGV)
      @options = Slop.parse(items, help: true) do
        banner "Usage: #{$0} [options...]"

        on 't', 'token=', 'Tracker API token.'
        on 'p', 'project=', 'Tracker Project ID.', as: :integer
        on 'd', 'date=', 'Story fetch date'
        on 'f', 'file=', 'Saved file path'
        on 'v', 'version', 'Display version information.' do
          puts "#{$0} #{JenkinsPivotal::VERSION}"
          exit 0
        end
      end
    end

    def run!
      unless options.token? && options.project?
        puts @options
        exit 1
      end

      Agent.new(
        token: options[:token],
        project: options[:project],
        date: options[:date],
        file: options[:file],
      ).run!
    end
  end
end
