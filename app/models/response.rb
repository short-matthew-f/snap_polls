# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  poll_id    :integer
#  content    :string
#  correct    :boolean          default("false")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ActiveRecord::Base
  belongs_to :poll
  
  has_many :votes
  
  validates :content, presence: true
  
  def is_correct!
    self.update_attribute(:correct, true)
  end
end
