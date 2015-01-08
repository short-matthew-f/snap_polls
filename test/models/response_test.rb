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

require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
