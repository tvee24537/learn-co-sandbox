class User < ActiveRecord::Base
  
  include Quantifiable::InstanceMethods
  
  has_secure_password
  validates :username, :uniqueness => {:case_sensitive => false} #This should validate if username exist already in the database
  validates_presence_of :username, :password

  has_many :lists, :dependent => :destroy
  has_many :items

  def lists_sort_by_name
    self.lists.all.sort_by {|list| list[:name]}
  end

end