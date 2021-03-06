require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end
end
