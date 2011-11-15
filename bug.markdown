The former talks about this issue can be found at [StackOverFlow](http://stackoverflow.com/questions/8130900/cant-update-the-attribute-with-activerecord)  
I used ActiveRecord in a stand alone script without rails runner.  
### The Environment is listed below.  
	rails:3.1.1
	ActiveRecord:3.1.1
### Source Code:
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
	  :password => "pw1234567!",
	  :database => "data_archieves"
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

The table answers only has one record,the table dump file is pushed here.  
[Mysql Dump File](https://raw.github.com/Zhengquan/Swap_Chars/bug_report/bug_answers.sql)
### Prbolem
When I only use update_attribute, It can't update the record.  
But when I replace this line with
	answer.reload
	answer.update_attributes(:content => str)
It indeed can update this only one record.  
Is it a bug in ActiveRecord when using it stand alone.
