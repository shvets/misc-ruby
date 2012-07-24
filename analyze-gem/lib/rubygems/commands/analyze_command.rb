# OpenCommand will analyze a gem's dependencies
class Gem::Commands::AnalyzeCommand < Gem::Command
  include AnalyzeGem::CommonOptions
  include Gem::VersionOption
  
  def initialize
    super 'analyze', "Analyze the gem's dependencies", 
      :command => nil, 
      :version=>  Gem::Requirement.default,
      :latest=>   false
    
    add_command_option
    add_latest_version_option
    add_version_option
    add_exact_match_option
  end
  
  def arguments # :nodoc:
    "GEMNAME       gem to analyze"
  end

  def execute
    name = get_one_gem_name
    path = get_path(name)
    
    analyze_gem(path + "/lib") if path
  end
  
  def get_path(name)
    if spec = get_spec(name)
      spec.full_gem_path
    end
  end

  def analyze_gem(path)
    p "analyzing: " + path

    Dir.entries("#{path}").each do |file_name|
      next if ['.', '..'].include? file_name

      if File.directory?("#{path}/" + file_name)
        analyze_gem("#{path}/" + file_name)
      elsif file_name =~ /.rb/
        f = File.open("#{path}/" + file_name)

        f.each do |line|
          if line.include?('require') then
            puts line
          end
        end
      end
    end
  end
end

