class List < ActiveRecord::Base
  
  include Quantifiable::InstanceMethods

  has_many :items, :dependent => :destroy
  belongs_to :user

end