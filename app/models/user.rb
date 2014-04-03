class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   has_many :teams, inverse_of: :user, autosave: true
   has_many :active_teams, -> { first }, class_name: "Team"
   accepts_nested_attributes_for :teams, allow_destroy: true
   accepts_nested_attributes_for :active_teams, allow_destroy: true
end
