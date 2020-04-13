class User < ActiveRecord::Base
  
  include Quantifiable::InstanceMethods
  
  has_secure_password

  has_many :lists, :dependent => :destroy
  has_many :items

  def lists_sort_by_name
    self.lists.all.sort_by {|list| list[:name]}
  end

end