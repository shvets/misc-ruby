require 'stringio'
require "rubygems/user_interaction"
require "rubygems/dependency_installer"


module Gemmer

  def self.included(base)
    new_gems = detect_new_gems $PROGRAM_NAME

    new_gems.each do |gem_name, gem_version|
      puts "Installing #{gem_name}-#{gem_version}..."

      install_gem gem_name, gem_version

      puts "OK."
    end

    if new_gems.size > 0
      puts "New gems installed. Please restart your program."
      #puts exec('ruby', $PROGRAM_NAME)
      Process.exit!
    end
  end

  protected
  
  def detect_new_gems program_name
    content = data_after_eof program_name

    new_gems = {}

    content.each_line do |line|
      line.strip!

      if(not line.empty?)
        elements = line.split(/[\s,"]/).reject{|s| s.strip.size == 0}

        gem_name = elements[1]
        gem_version = (elements.size > 2) ? elements[2] : nil

#        puts gem_name
#        puts gem_version

        matches = Gem.source_index.find_name(gem_name, gem_version)

        if matches.empty?
#          `gem i #{gem_name} -v #{gem_version}`

          new_gems[gem_name] = gem_version
        end
      end
    end

    new_gems
  end

  def install_gem gem_name, gem_version
    options = { :install_dir         => Gem.dir,
                :ignore_dependencies => true,
                :wrappers            => true,
                :env_shebang         => true }

    inst = Gem::DependencyInstaller.new options

    inst.install gem_name, gem_version
  end

  def data_after_eof file_name
    program_file = File.open(file_name)

    content = program_file.read.split( /^__END__/, 2 ).last

    StringIO.new content
  end

end