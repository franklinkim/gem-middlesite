require "git"
require "thor"
require "yaml"

module Middlesite
  class Cli < Thor

    desc "init", "Initialize the workspace."
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

    desc "deploy", "Build and deploy to server"
    def deploy
      system "bundle exec middleman deploy"
    end

    desc "bump [TYPE]", "Bump version (patch|minor|major), commit, tag, and push."
    def bump(type="patch")
      # Get latest git tag
      raise Thor::Error, "Not a git repository!" unless Dir.exists?(".git")
      g = ::Git.open(".")
      raise Thor::Error, "Uncommitted git changes!" unless g.status.changed.empty?

      config = get_config()
      version = config["version"]

      # Bump version
      case type
      when "major"
        version = bump_major(version)
      when "minor"
        version = bump_minor(version)
      when "patch"
        version = bump_patch(version)
      else
        raise Thor::Error, "Unknown bump type!"
      end
      puts "Bumping version to: #{version}"

      # update config
      puts "Updating site config..."
      config["version"] = version
      set_config(config)

      # commit & add tag
      g.commit_all("release v#{version}")
      puts "Adding tag..."
      g.add_tag("v#{version}")
      g.repack

      # push
      puts "Pushing files..."
      g.push("origin", "master", true)
    end

    no_tasks do
      def get_config
        YAML::load(File.open("./data/site.yml"))
      end

      def set_config (config)
        File.open("./data/site.yml", "w") do |f|
          f.write(config.to_yaml)
        end
      end

      def bump_patch(version)
        version = version.split(".")
        version[0] = version[0].to_i
        version[1] = version[1].to_i
        version[2] = version[2].to_i + 1
        version.join(".")
      end

      def bump_minor(version)
        version = version.split(".")
        version[0] = version[0].to_i
        version[1] = version[1].to_i + 1
        version[2] = 0
        version.join(".")
      end

      def bump_major(version)
        version = version.split(".")
        version[0] = version[0].to_i + 1
        version[1] = 0
        version[2] = 0
        version.join(".")
      end
    end

  end
end