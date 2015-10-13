module HomesHelper
  
  def balance_winning
    winnings_by_day = Tran.total_grouped_by_day(7.days.ago, current_user)
    balances_by_day = Account.total_grouped_by_day(7.days.ago, current_user)
    rtn_ary = [{period: 7.days.ago.to_date, sales: nil, profit: nil}]
      (7.days.ago.to_date..Date.today).map do |date|
       rtn_ary << {period: date, 
          sales: winnings_by_day[date].try(:first).try(:total_stakes) || 0,
          profit: balances_by_day[date].try(:first).try(:total_balance) || rtn_ary.last[:profit]
        }
    end
    rtn_ary
  end
  
end
