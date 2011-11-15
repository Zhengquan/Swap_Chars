#!/usr/bin/env ruby
#encoding: utf-8
####BEGIN INFO
## System: Ubuntu
## Desc  : migrate databases
## Author: yangzhengquan@gmail.com
####END INFO
#
#require File.expand_path("./orm")
require 'rubygems'
require 'require_all'

require_all 'lib'

Archieve::Answer.find_each do |answer|
  str = answer.content
  str = "测试"
  str.strip!
  answer.update_attribute(:content, str)
end
