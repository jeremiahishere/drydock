require "bundler/gem_tasks"
require 'drydock'

task :test do
  runner = Drydock::Launcher::TestRun.new("./dockerfile.template.erb", "/Users/jeremiah/code/docker_hello_world")
  runner.run
end
