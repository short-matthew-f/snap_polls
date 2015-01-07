class Poll < ActiveRecord::Base
  has_many :responses
  has_many :votes, through: :responses
  
  accepts_nested_attributes_for :responses, reject_if: proc { |attr| attr['content'].blank? }
end
