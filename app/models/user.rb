class User < ActiveRecord::Base
  has_secure_password
  has_many :missions
  validates_presence_of :username, :email, :password

  def slug
    u= self.username
    u.gsub(" ","-")
  end

  def self.find_by_slug(param)
    param.gsub!("-"," ")
    User.find_by(:username => param)
  end


end
