class PlayerPresenter
	def self.dropdowns()
		self.new()
	end

  attr_reader :players
	def initialize()
	end
	def newtemplate(template)
		@template = template
		yield(self) if (block_given?)
	end
  def h
    @template
  end
  def newplayers(players, sort_column)
    @players = players
    @sort_column = sort_column
  end
  def playertemplate(template)
    @playertemplate = template
    yield(self) if (block_given?)
  end
  def ph
    @playertemplate
  end

	def price_bands
      max = Player.maximum(:price)
      min = Player.minimum(:price)
      steps = (max - min)/10.0
      bands = [] 
      10.times { |x| bands[x] = min + (steps * (x + 1.0))}
      bands.reverse!
  end

  def team_selection
    ["All", "Goalies", "Defenders", "Midfielders", "Strikers"] + (Player.teams.map{|x| x.club})
  end

  def dropdown_options(selection)
    selection.map.with_index { |key, i|
       option_options = { :value => key }
       option_options.merge!(:selected => "selected") if i == 0
       h.content_tag(:option, key, option_options)
     }.join.html_safe
  end
  def dropdown_hash_options(selection)
    selection.map.with_index { |key, i|
       option_options = { :value => key[1] }
       option_options.merge!(:selected => "selected") if i == 0
       h.content_tag(:option, key[0], option_options)
     }.join.html_safe
  end


  def team_dropdown
  	h.content_tag(:select, dropdown_options(team_selection),
  		class: "form-control playerdropdown", 
      id: "teamselect_id", name:"teamselect[id]")
	end

  def playersort_dropdown
    h.content_tag(:select, dropdown_hash_options(PLAYER_SORT),
      class: "form-control playerdropdown", 
      id: "playersort_id", name:"playersort[id]")
  end
  def priceband_dropdown
    h.content_tag(:select, dropdown_options(price_bands),
      class: "form-control playerdropdown", 
      id: "priceband_id", name:"priceband[id]")
  end

  def each_player(&block)
    @players.sort{|a,b| [a[:position], b[@sort_column]] <=> 
     [b[:position], a[@sort_column]]}.each(&block)
  end
  def label(hash_values)
    fieldname = hash_values.fetch(:name)
    shortname = hash_values.fetch(:short, fieldname.titleize)
    optional_class = hash_values.fetch(:op, true)
    ph.content_tag(:th, shortname, 
      class: optional_class ? "#{fieldname} optional" : fieldname )
  end

  def current_player(player)
    @player = player
  end
  def stats(hash_values)
    classes = fieldname = hash_values.fetch(:field)
    optional_class = hash_values.fetch(:op, true)
    visprice_class = hash_values.fetch(:visprice, false)
    precision = hash_values.fetch(:prec, false)
    classes += " optional" if optional_class
    classes += " visprice" if visprice_class
    newvalue = if precision
      ph.number_with_precision(@player[fieldname], precision:1) 
    else
      @player[fieldname]
    end
    ph.content_tag(:td, newvalue , class: classes )
  end

  PLAYER_SORT =  {
    "Total Points"=>        "total_points",
    "Price"=>               "price",
    "Round Score"=>         "round_score",
    "Teams Selected by"=>   "teams_selected_percent",
    "Minutes Played"=>      "minutes_played",
    "Goals Scored"=>        "goals_scored",
    "Assists"=>             "assists",
    "Clean Sheets"=>        "clean_sheets",
    "Goals Conceded"=>      "goals_conceded",     
    "Own Goals"=>           "own_goals",
    "Penalties Saved"=>     "penalties_saved",
    "Penalties Missed"=>    "penalties_missed",
    "Yellow Cards"=>        "yellow_cards",
    "Red Cards"=>           "red_cards",
    "Saves"=>               "saves",
    "Bonus"=>               "bonus",
    "Round Bonus"=>         "round_bonus",
    "Form"=>                "form",
    "Dream Team Appearances"=> "dream_team_appearances",
    "Value Form"=>           "value_form",
    "Value Season"=>         "value_season",
    "Points Per Game"=>      "points_per_game",
    "Transfers In"=>         "transfers_in",
    "Transfers Out"=>        "transfers_out",
    "Transfers In Round"=>   "transfers_in_round",
    "Transfers Out Round"=>  "transfers_out_round",
    "Price Rise"=>           "price_rise",
    "Price Fall"=>           "price_fall",
    "Price Rise Round"=>     "price_rise_round",
    "Price Fall Round"=>     "price_fall_round"
  }
end

