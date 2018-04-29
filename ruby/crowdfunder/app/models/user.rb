class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  
  has_many :pledges, foreign_key: :backer_id
  has_many :rewards, through: :pledges
  has_many :backed_projects, through: :pledges, source: :project
  has_many :owned_projects, class_name: "Project"
  def amount_spent
  	self.pledges.sum(:amount)
  end
end

