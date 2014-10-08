class Client < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :user

  belongs_to :user
  has_many :sales
end
