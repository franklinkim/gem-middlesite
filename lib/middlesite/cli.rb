require "thor"
require "yaml"

module Middlesite
  class Cli < Thor

    desc "init" "Initialize the workspace."
    def init
      puts "Installing gems..."
      system "bundle install"
      puts ""
      puts "Installing bower packages..."
      system "bower install"
    end

    desc "build", "Generate build from sources"
    method_option :verbose, :aliases => "-v", :type => :boolean, :default => false
    def build
      if options[:verbose]
        system "bundle exec middleman build --verbose"
      else
        system "bundle exec middleman build"
      end
    end

    desc "server", "Build and start server"
    def server
      system "bundle exec middleman server"
    end
  end
end