#!/usr/bin/env ruby
# encoding:utf-8
# A Script to migtate the database using ActiveRecord
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

#log level
ActiveRecord::Base.logger = Logger.new(STDERR)


config = YAML::load(File.open("database.yaml","r")) 
$archieve_config = config["archieve_db"]

#magic database
module Archieve
  class Question < ActiveRecord::Base
    establish_connection $archieve_config
    attr_accessible :id,:user_id, :title, :credit, :is_community, :answers_count, :content
    include Extensions::UUID
  end
  class Answer < ActiveRecord::Base
    establish_connection $archieve_config
    attr_accessible :id, :user_id, :question_id, :content
    include Extensions::UUID
  end
end
