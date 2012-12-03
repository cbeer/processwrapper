require "processwrapper/version"

require 'childprocess'
require 'active_support/core_ext/hash'
require 'erb'
require 'yaml'
require 'timeout'
require 'socket'

class Processwrapper
  def initialize *args, &block
    options = args.extract_opts!

    file = args.first

    if file
      config_yml = load_config_from_file(file)
      config.configure(config_yml)
    end

    config.configure(options, &block)
  end

  def config
    @config ||= Confstruct::Configuration.new
  end

  def around &block
    start
    yield
    stop
  end

  def start

  end

  def stop

  end

  def restart
    stop; start
  end

  def status

  end

  def configtest

  end

  def pid

  end

  private

  def is_service_running?

  end

  def load_config_from_file file

    return @config_yml if @config_yml
    unless File.exists?(file)
      raise "You are missing a solr configuration file: #{file}"  
    end

    begin
      @config_erb = ERB.new(IO.read(file)).result(binding)
    rescue Exception => e
      raise("#{file} was found, but could not be parsed with ERB. \n#{$!.inspect}")
    end

    begin
      @config_yml = YAML::load(@config_erb)
    rescue StandardError => e
      raise("#{file} was found, but could not be parsed.\n")
    end

    if @config_yml.nil? || !@config_yml.is_a?(Hash)
      raise("#{file} was found, but was blank or malformed.\n")
    end

    @config_yml.with_indifferent_access


    config[config_name]
  end

  def config_name
    if defined? Rails 
      Rails.env
    else 
      ENV['environment']
    end
  end
end
