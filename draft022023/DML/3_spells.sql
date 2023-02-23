INSERT INTO spells(name, type_id, is_physical, power, cost, acc_multiplier, effect_id)
	VALUES	('Blister',
			(SELECT id FROM monster_types WHERE name = 'FLAME'),
			FALSE,
			10,
			0,
			1.0,
			(SELECT id FROM move_effect WHERE name = 'NO_EFFECT')),
			('Bite',
			(SELECT id FROM monster_types WHERE name = 'BEAST'),
			TRUE,
			15,
			0,
			1.0, 
			(SELECT id FROM move_effect WHERE name = 'NO_EFFECT')),
			('Claw',
			(SELECT id FROM monster_types WHERE name = 'BEAST'),
			TRUE,
			12, 
			0,
			0.8),
			('Root drain',
			(SELECT id FROM monster_types WHERE name = 'PLANT'),
			FALSE,
			20,
			1,
			1.0
			);

INSERT INTO move_effect