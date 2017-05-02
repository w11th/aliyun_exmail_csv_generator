# coding: utf-8
require 'spec_helper'

module AliyunExmailCSVGenerator
  describe Account do
    context '#initialize' do
      context 'without options' do
        before do
          @account = Account.new('David', 'david@qcpt.org')
        end
        it 'has default password' do
          expect(@account.password).to eq(Account::DEFAULT_OPTIONS[:password])
        end

        it 'has default department' do
          expect(@account.department).to eq(Account::DEFAULT_OPTIONS[:department])
        end

        it 'has default capacity' do
          expect(@account.capacity).to eq(Account::DEFAULT_OPTIONS[:capacity])
        end
      end

      context 'with options' do
        before do
          @options = {password: 'override', department: 'new department', mobile: '12345', capacity: 1024}
        end
        it 'overrides the default option' do
          account = Account.new('test', 'test@wang.org', @options)

          expect(account.password).to eq(@options[:password])
          expect(account.department).to eq(@options[:department])
          expect(account.mobile).to eq(@options[:mobile])
          expect(account.capacity).to eq(@options[:capacity])
        end

        it 'should be default if not specific' do
          @options[:department] = nil
          account = Account.new('test', 'test@wang.org', @options)
          expect(account.department).to eq(Account::DEFAULT_OPTIONS[:department])
        end
      end
    end

    context '#to_csv_row' do
      it 'should work' do
        account = Account.new('David', 'david@qcpt.org', {department: 'Org', title: 'Manager'})
        expect(account.to_csv_row).to eq(['David', 'david@qcpt.org', nil, Account::DEFAULT_OPTIONS[:password], 'Org', nil, 'Manager', nil, Account::DEFAULT_OPTIONS[:capacity]])
      end
    end

    context '.name_to_pinyin' do
      before do
        @name_list = %w(张三 李四 王五一 David\ Bowie)
        @name_pinyin_list = ['san.zhang', 'si.li', 'wuyi.wang', 'bowie.david']
      end

      it 'should transform name to pinyin' do
        @name_list.each_with_index do |name, index|
          expect(Account.name_to_pinyin(name)).to eq(@name_pinyin_list[index])
        end
      end
    end

    context '.from' do
      before do
        @name_list = %w(张三 李四 王五一 David\ Bowie)
      end
      it 'should transform name list to account list' do
        accounts = Account.from(@name_list)
        accounts.each_with_index do |account, index|
          expect(account.name).to eq(@name_list[index])
        end
      end
    end
  end
end
