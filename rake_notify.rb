#!/usr/bin/env ruby

begin
  require 'rake'
rescue LoadError
  require 'rubygems'
  require 'rake'
end

class Rake::Application
  def task_list
    top_level_tasks.join(' ')
  end

  def notify(message, body, urgency, icon = :info)
    system("notify-send --urgency=#{urgency} --icon=#{icon} '#{message}' '#{body}'")
  end

  def after_run
    notify('Rake Tasks: Finished', task_list, :low)
  end

  def after_fail
    notify('Rake Tasks: Failed', task_list, :normal, :error)
  end

  def top_level_with_callbacks
    top_level_without_callbacks

    after_run
  end

  alias_method :top_level_without_callbacks, :top_level
  alias_method :top_level, :top_level_with_callbacks

  def run_with_callbacks
    begin
      run_without_callbacks
    rescue SystemExit => e
      after_fail

      exit(falses)
    end
  end

  alias_method :run_without_callbacks, :run
  alias_method :run, :run_with_callbacks
end

Rake.application.run
