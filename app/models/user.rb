class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :open_account
  has_many :accounts
  has_many :trans
  
  def open_account
    self.accounts.create(balance: 1000)
  end
  
  
end
