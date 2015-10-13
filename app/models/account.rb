class Account < ActiveRecord::Base
  belongs_to :user
  
  def self.total_grouped_by_day(start, current_user)
      balances = where(created_at: start.beginning_of_day..Time.zone.now, user_id: current_user.id)
      balances = balances.group("date(created_at)")
      balances = balances.select("created_at, balance as total_balance")
      balances.group_by {|o| o.created_at.to_date }
  end
end
