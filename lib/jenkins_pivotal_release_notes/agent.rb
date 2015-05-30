require 'tracker_api'

module JenkinsPivotalReleaseNotes
  class Agent
    attr_reader :token, :project, :date, :file

    def initialize(options)
      @token = options[:token]
      @project = options[:project].to_i
      @date = options[:date]
      @file = options[:file]
    end

    def run!
      puts date
      puts file
      output = ""
      client = TrackerApi::Client.new(token: token)
      currentProject  = client.project(project)
      featureStories = currentProject.stories(filter: 'accepted_since:' + date  + ' type:Feature')
      inProgressStories = currentProject.stories(filter: 'state:started state:finished state:delivered type:Feature')
      bugStories = currentProject.stories(filter: '-state:delivered -state:accepted type:Bug')
      output.concat(currentProject.name + " Release Notes\n\n")
      if featureStories.size > 0
        output.concat("NEWLY COMPLETED FEATURES\n")
        output.concat("========================\n")
        for story in featureStories
          output.concat(story.name + "\n")
        end
      end

      if inProgressStories.size > 0
        output.concat("IN PROGRESS FEATURES\n")
        output.concat("====================\n")
        for story in inProgressStories
          output.concat(story.name + "\n")
        end
        output.concat("\n")
      end

      if bugStories.size > 0
        output.concat("KNOWN BUGS\n")
        output.concat("==========\n")
        for story in bugStories
          output.concat(story.name + "\n")
        end
        output.concat("\n")
      end

      File.write(file, output)
    end

    def changelog_paths
      # TODO this should be extracted into ChangelogGatherer or something
      if ENV['CHANGELOG_PATH']
        return [ ENV['CHANGELOG_PATH'] ]
      end

      start_from = 1
      default_changelog = File.join env_variables['JENKINS_HOME'],
        'jobs', env_variables['JOB_NAME'],
        'builds', env_variables['BUILD_NUMBER'],
        'changelog.xml'

      # If it's the first build, there's nothing to gather.
      if env_variables['BUILD_NUMBER'] == '1'
        return [ default_changelog ]
      end

      last_success = File.join env_variables['JENKINS_HOME'],
        'jobs', env_variables['JOB_NAME'],
        'builds', 'lastSuccessfulBuild'

      last_success_num = File.readlink last_success
      if last_success_num != '-1'
        # If the lastSuccessfulBuild was the previous build then the
        # changelog will already be adequate.
        if last_success_num.to_i == env_variables['BUILD_NUMBER'].to_i - 1
          return [ default_changelog ]
        else
          start_from = last_success_num.to_i + 1
        end
      end

      start_from.upto(env_variables['BUILD_NUMBER'].to_i).map do |i|
        File.join env_variables['JENKINS_HOME'],
          'jobs', env_variables['JOB_NAME'],
          'builds', i.to_s,
          'changelog.xml'
      end
    end

    private

    def env_variables
      ENV
    end

    def changelog_path
      if ENV['CHANGELOG_PATH']
        return ENV['CHANGELOG_PATH']
      end

      File.join ENV['JENKINS_HOME'],
        'jobs', ENV['JOB_NAME'],
        'builds', ENV['BUILD_NUMBER'],
        'changelog.xml'
    end
  end
end
