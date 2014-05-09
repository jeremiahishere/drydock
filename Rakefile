require "bundler/gem_tasks"
require 'drydock'

task :test do
  template = ENV['TEMPLATE'] || "./dockerfile.template.erb"
  destination = ENV['DESTINATION'] || "./docker_project"
  runner = Drydock::Launcher::TestRun.new(template, destination)
  runner.run
end

task :sshable do
  template = ENV['TEMPLATE'] || "./docker-sshable.template.erb"
  destination = ENV['DESTINATION'] || "./sshable_project"
  runner = Drydock::Launcher::TestRun.new(template, destination)
  runner.run
end
