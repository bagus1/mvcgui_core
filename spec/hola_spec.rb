# require 'spec_helper'
#require '../lib/hola.rb'
require 'pry'
require_relative '../lib/hola.rb'
describe "Hola" do 
  
  it "beep" do  
     binding.pry
     STDOUT.should_receive(:puts).with('Hello world!')
Hola.hi
  end
end