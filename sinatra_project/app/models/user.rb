class User < ActiveRecord::Base
  
  has_secure_password

  has_many :categories, :dependent => :destroy
  has_many :expenses

  def lists_sort_by_name
    self.lists.all.sort_by {|list| list[:name]}
  end

end