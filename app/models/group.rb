class Group < ApplicationRecord
  ## Association
  belongs_to :owner, class_name: 'User'
  has_many :group_members
  has_many :posts, dependent: :destroy

  ## scope
  # scope :owner_groups, -> { where(owner: current_use) }
  scope :member_groups, -> (user) { joins(:group_members).where(group_members: { member: user })}

  ## callback
  after_create_commit :make_owner_as_member

  def make_owner_as_member
    self.group_members.create(member_id: self.owner_id)
  end

  def member?(user)
    group_members.exists?(member: user)
  end

  def owner?(user)
    owner == user
  end
end
