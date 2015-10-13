class Tran < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  after_create :set_user
  after_create :create_account
  after_update :update_balance
  
  
  def set_user
    current_user = self.account.user.id
    self.update(user_id: current_user)
  end
  
  def create_account
    balance = self.account.user.accounts.last.balance
    accounts = self.account.user.accounts
    accounts.create(balance: balance - self.stake, stake_ratio: self.stake/balance)
  end
  
  def update_balance
    balance = self.account.user.accounts.last.balance
    accounts = self.account.user.accounts
    accounts.last.update(balance: balance + self.winnings)
  end
  
  
  def self.total_grouped_by_day(start, current_user)
      winnings = where(created_at: start.beginning_of_day..Time.zone.now, user_id: current_user.id)
      winnings = winnings.group("date(created_at)")
      winnings = winnings.select("created_at, sum(winnings) as total_winnings, sum(stake) as total_stakes")
      winnings.group_by {|o| o.created_at.to_date }
  end
  
end
