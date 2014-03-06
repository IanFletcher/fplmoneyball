class Player < ActiveRecord::Base
  has_many :team_players, inverse_of: :player

	self.per_page = 30

  scope :teams, -> {select("club").group("club")}
  scope :bandlevel, -> (band) {where('price <=?', band )}

  def self.market_filter(club, price_band, column)
    self.selectclub(club).bandlevel(price_band).order(column + ' DESC')
  end
  def self.selectclub(club) 
    case club
      when 'All' then all
      when "Defenders","Goalies","Midfielders","Strikers"
        where("position=?", club[0].downcase)
      else where("club=?", club)
    end
  end
end
