local function perkeo_main_menue(change_context)
	G.title_top.cards[1]:set_base(G.P_CARDS["S_A"], true)
	-- Credit to the Cryptid mod for the original code to add a card to the main menu
	local title_card = SMODS.create_card({key='j_perkeo', edition='e_negative',area = G.title_top})
	G.title_top:emplace(title_card)
	title_card.states.visible = false
	title_card.no_ui = true
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = change_context == "game" and 1.5 or 0,
		blockable = false,
		blocking = false,
		func = function()
			if change_context == "splash" then
				title_card.states.visible = true
				title_card:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 2.5)
				play_sound("whoosh1", math.random() * 0.1 + 0.3, 0.3)
				play_sound("crumple" .. math.random(1, 5), math.random() * 0.2 + 0.6, 0.65)
			else
				title_card.states.visible = true
				title_card:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1.2)
			end
			G.VIBRATION = G.VIBRATION + 1
			return true
		end,
	}))
end

local game_main_menu_ref = Game.main_menu

function Game:main_menu(change_context)
	local ret = game_main_menu_ref(self, change_context)
	perkeo_main_menue(change_context)
	return ret
end

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
						return true
					end
				}))
			end
		end
	end
}

