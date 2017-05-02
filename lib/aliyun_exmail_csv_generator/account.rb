# coding: utf-8
require 'ruby-pinyin'

module AliyunExmailCSVGenerator
  class Account
    DEFAULT_OPTIONS = {
      workno: nil,
      password: 'Hello1234',
      department: '公司',
      phone_ext: nil,
      title: nil,
      mobile: nil,
      capacity: 2048
    }

    def initialize(name, email, options = DEFAULT_OPTIONS)
      @name       = name
      @email      = email

      @workno     = options[:workno]
      @password   = options[:password] || DEFAULT_OPTIONS[:password]
      @department = options[:department] || DEFAULT_OPTIONS[:department]
      @phone_ext  = options[:phone_ext]
      @title      = options[:title]
      @mobile     = options[:mobile]
      @capacity   = options[:capacity] || DEFAULT_OPTIONS[:capacity]
    end

    def to_csv_row
      [@name, @email, @workno, @password, @department, @phone_ext, @title, @mobile, @capacity]
    end

    class << self
      def from(name_list, options)
        accounts = []
        name_list.each do |name|
          name_pinyin = name_to_pinyin(name)
          email = "#{name_pinyin}@qcpt.org"
          accounts << Account.new(name, email, options)
        end
        accounts
      end

      def name_to_pinyin(name)
        name_pinyin = PinYin.of_string(name)
        name_pinyin = name_pinyin.push('.').rotate! if name_pinyin.length > 1
        name_pinyin.join
      end
    end
  end
end
