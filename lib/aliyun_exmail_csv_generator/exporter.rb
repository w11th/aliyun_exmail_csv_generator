# coding: utf-8
require 'csv'
require 'fileutils'

module AliyunExmailCSVGenerator
  module Exporter
    class << self
      def accounts_to_csv(accounts, filepath)
        filepath = File.absolute_path(File.expand_path(filepath))
        filedir = File.dirname filepath
        FileUtils.mkdir_p filedir unless File.exist? filedir
        CSV.open(filepath, 'w:UTF-8:GB2312') do |csv|
          csv << ["#姓名", "邮件地址", "工号", "密码", "部门", "分机", "职称", "手机号", "容量"]
          accounts.each do |account|
            csv << account.to_csv_row
          end
        end
        filepath
      end
    end
  end
end
