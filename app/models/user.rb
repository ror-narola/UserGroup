class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association
  has_many :group_members, foreign_key: :member_id
  # has_many :member_groups, through: :group_members
  has_many :groups, foreign_key: :owner_id

  def user_name
    return "#{self.first_name} #{self.last_name}"
  end
end
