#!/usr/bin/env ruby
#encoding: utf-8
####BEGIN INFO
## System: Ubuntu
## Desc  : A script to report bug for ActiveRecord
## Author: yangzhengquan@gmail.com
####END INFO
#
require 'rubygems'
require 'logger'
require 'yaml'
require 'uuidtools'
require 'active_record'

module Extensions
  module UUID
    extend ActiveSupport::Concern
    included do
      set_primary_key 'id'
    end
  end
end

ActiveRecord::Base.logger = Logger.new(STDERR)

#the connection config
$archieve_config = {
  :adapter => "mysql2",
  :host => "localhost",
  :username => "root",
  :password => "password",
  :database => "database"
}

module Archieve
  class Answer < ActiveRecord::Base
    establish_connection $archieve_config
    attr_accessible :id, :content
    include Extensions::UUID
  end
end

Archieve::Answer.find_each do |answer|
  str = answer.content
  str.gsub!(/引用:原帖由[\s\S]+发表/,"")
  str.strip!
  #answer.update_attribute(:content, str)
  answer.reload
  answer.update_attributes(:content => str)
end
