require 'optparse'

module AliyunExmailCSVGenerator
  module Optparser
    def self.parse(args)
      options = {}

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: aliyun_exmail_csv_generator [options]'

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

    end
  end
end
