require 'rubygems/command_manager'

require 'rubygems/command'
require 'rubygems/dependency'
require 'rubygems/version_option'

require 'shellwords'
require 'analyze_gem/common_options'

Gem::CommandManager.instance.register_command :analyze