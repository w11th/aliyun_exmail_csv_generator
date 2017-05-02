require "aliyun_exmail_csv_generator/version"
require "aliyun_exmail_csv_generator/optparser"

module AliyunExmailCSVGenerator
  # Your code goes here...
  autoload :Account, 'aliyun_exmail_csv_generator/account'
  autoload :Exporter, 'aliyun_exmail_csv_generator/exporter'
end
