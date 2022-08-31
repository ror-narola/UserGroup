class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :reply_of, class_name: "Comment", optional: true
  has_many :comments, :foreign_key => "reply_of_id"
end
