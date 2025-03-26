SMODS.Atlas{
	key = 'jokers',
	path = 'Jokers.png',
	px = 71,
	py = 95,
	-- 2x is 144 by 190
}

SMODS.Joker{
	key = 'Perk-O-lator',
	atlas = 'jokers',
	pos = {x = 0, y = 0},
	soul_pos = { x = 0, y = 1 },
	blueprint_compat = true,
	loc_txt = {
		name = 'Perk-O-lator',
		text = {
			"Creates a {C:dark_edition}Negative{} copy of",
			"{C:green}Perkeo{}",
			"at the end of the {C:attention}shop",
	}},
	calculate = function (self,card,context)
		if context.ending_shop then
			G.E_MANAGER:add_event(Event({
				func = function()
					local card = create_card('Perkeo', G.jokers, nil,nil,nil,nil,'j_perkeo')
					card:set_edition('e_negative', true)
					card:add_to_deck()
					G.jokers:emplace(card)
					return true
				end
			}))
		end
	end
}