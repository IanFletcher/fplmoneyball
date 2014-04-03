# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gameweek_balancesheet do
    gameweek_id 1
    team_id 1
    open_cash "9.99"
    open_team_value "9.99"
    player_earnings "9.99"
    costs_variable "9.99"
    costs_fixed "9.99"
    transfer_fees "9.99"
    player_exchange_value "9.99"
    cash "9.99"
    team_value "9.99"
  end
end
