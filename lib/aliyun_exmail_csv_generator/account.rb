require 'ruby-pinyin'

module AliyunExmailCSVGenerator
  class Account
    DEFAULT_OPTIONS = {
      workno: nil,
      password: 'Hello1234',
      phone_ext: nil,
      title: nil,
      mobile: nil,
      capacity: 2048
    }

    def initialize(name, email, department, options = DEFAULT_OPTIONS)
      @name       = name
      @email      = email
      @department = department

      @workno     = options[:workno]
      @password   = options[:password]
      @phone_ext  = options[:phone_ext]
      @title      = options[:title]
      @mobile     = options[:mobile]
      @capacity   = options[:capacity]
    end

    def to_csv_row
      [@name, @email, @workno, @password, @department, @phone_ext, @title, @mobile, @capacity]
    end

    class << self
      def from(name_list, department, options)
        accounts = []
        name_list.each do |name|
          name_pinyin = PinYin.of_string(name)
          name_pinyin = name_pinyin.push('.').rotate! if name_pinyin.length > 1
          email = "#{name_pinyin.join}@qcpt.org"
          accounts << Account.new(name, email, department, options)
        end
        accounts
      end
    end
  end
end
