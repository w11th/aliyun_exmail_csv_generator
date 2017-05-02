# coding: utf-8
require 'optparse'
require 'ostruct'

module AliyunExmailCSVGenerator
  module Optparser
    def self.parse(args)
      options = OpenStruct.new

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: aliyun_exmail_csv_generator [options] name_list_file'

        opts.on('-o', '--output OUTPUT', 'Output file path') do |output|
          options.output = output
        end

        opts.on('-d', '--dept DEPT', 'Set the department of accounts') do |dept|
          options.department = dept
        end

        opts.on('-p', '--password PASSWORD', 'Set the default password of accounts') do |password|
          options.password = password
        end

        opts.on_tail('-v', '--version', 'Show this version') do
          puts AliyunExmailCSVGenerator::VERSION
          exit
        end

        opts.on_tail('-h', '--help', 'Show this message') do
          puts opts
          exit
        end
      end

      opt_parser.parse!(args)

      name_list = []
      ARGF.each_line do |line|
        line.strip!
        name_list << line.strip unless line.empty?
      end

      unless options.department
        puts "Input the department (type enter for default: #{Account::DEFAULT_OPTIONS[:department]}):"
        department = $stdin.gets.strip!
        options.department = department unless department.empty?
      end

      accounts = Account.from(name_list, options)

      output = options.output || 'output.csv'

      Exporter.accounts_to_csv(accounts, output)
    end
  end
end
