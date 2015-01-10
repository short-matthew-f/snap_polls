# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  question   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  active     :boolean          default("true")
#

class Poll < ActiveRecord::Base
  acts_as_taggable
  
  has_many :responses
  has_many :votes, through: :responses
  
  accepts_nested_attributes_for :responses, reject_if: proc { |attr| attr['content'].blank? }
  
  validates :question, presence: true
  validates :responses, presence: true
  
  def close!
    self.update_attribute(:active, false)
  end
end
