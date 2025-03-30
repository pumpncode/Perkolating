SMODS.Atlas{
	key = 'jokers',
	path = 'Jokers.png',
	px = 71,
	py = 95,
	-- 2x is 144 by 190
}


SMODS.Joker{
	key = 'PerkOlator',
	atlas = 'jokers',
	pos = {x = 0, y = 0},
	soul_pos = { x = 0, y = 1 },
	blueprint_compat = true,
	rarity = 'Perkolator_Perkeo_R',
	calculate = function (self,card,context)
		if context.ending_shop then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
						SMODS.add_card({key='j_perkeo', edition='e_negative'})
							return true
						end
					}))
					return true
				end
			}))
		end
	end
}

SMODS.Joker{
	key = 'Perkmentia',
	atlas = 'jokers',
	pos = {x = 1, y = 0},
	rarity = 'Perkolator_Perkeo_R',
	blueprint_compat = true,
	calculate = function (self,card,context)
		if context.ending_shop and context.main_eval then
			local card = pseudorandom_element(G.consumeables.cards, pseudoseed('Perkmentia'))
			if card then 
				G.E_MANAGER:add_event(Event({
					func = function()
						card:start_dissolve()
						local consumable_types = {'Tarot','Spectral','Planet'}
						SMODS.add_card({set =  pseudorandom_element(consumable_types, pseudoseed('Perkmentia')), area = G.consumeables, edition = 'e_negative' })
						SMODS.add_card({set =  pseudorandom_element(consumable_types, pseudoseed('Perkmentia')), area = G.consumeables, edition = 'e_negative' })
						return true
					end
				}))
			end
		end
	end
}

SMODS.Joker{
	key = 'PNA',
	atlas = 'jokers',
	pos = {x = 1, y = 1},
	rarity = 'Perkolator_Perkeo_R',
	blueprint_compat = true,
	calculate = function (self,card,context)
		if context.individual and context.cardarea == G.play then
			if #context.full_hand  == 1 and  G.GAME.current_round.hands_played == 0  then
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
				_card:set_edition('e_negative', true)
				_card:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, _card)
				G.hand:emplace(_card)
				_card.states.visible = nil

				G.E_MANAGER:add_event(Event({
					func = function()
						_card:start_materialize()
						return true
					end
				})) 
				return {
					message = localize('k_copied_ex'),
					colour = G.C.CHIPS,
					playing_cards_created = {true}
				}
			end
		end
	end
}
