require 'pry'

module Flyable
  def flying
    puts "I can fly"
  end
end 

module Species
  def what_am_i
    puts "I am a #{self.to_s.downcase}"
  end
end

class Fish
  include Flyable
  extend Species
  def swimming
    puts "I can swimming"
  end
end

Fish.new.swimming #from self method 
Fish.new.flying #from included module, get power from instance method
Fish.what_am_i #from extend module, get power from class method

module Foo
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      include InstanceMethods
    end
  end

  module ClassMethods
    def hello
      new.world
    end
  end

  module InstanceMethods
    def world
      puts "Hello, world"
    end
  end
end

class Bar
  include Foo
  hello
end

hr {
      max-width: 90%;
      width: 550px;
      border-bottom: 1px solid #BA0C2F;
      border-top: 1px solid #BA0C2F; 
    }


def accepted_friends(user)
      user
        .friends
        .select("users.*, friendships.mutual_friends_count")
        .order("mutual_friends_count DESC")
        .recent
        .includes(:profile)
        .page(params[:page])
        .per(params[:per_page])
    end