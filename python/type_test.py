import unittest
import sqlite3
import os
import os.path
import db_init
import random


class TypeTest(unittest.TestCase):
    def test_types(self):
        if not os.path.exists('draft23.db'):
            db_init.insert_everything(database_name='draft23.db')
        sql_conn = sqlite3.connect('draft23.db')
        my_cursor = sql_conn.cursor()
        my_cursor.execute('SELECT COUNT(id) FROM monster_types')
        type_count = my_cursor.fetchone()[0]
        atk_type = random.randint(1, type_count)
        my_cursor.execute('SELECT type_name FROM monster_types WHERE  id = ?', (atk_type,))
        atk_type_name = my_cursor.fetchone()[0]
        def_type1 = random.randint(1, type_count)
        def_type2 = random.randint(1, type_count)
        my_cursor.execute('SELECT effect FROM type_effectiveness WHERE atk_type = ? AND def_type = ?', (atk_type,
                                                                                                        def_type1))
        type_effect1 = my_cursor.fetchone()[0]
        my_cursor.execute('SELECT effect FROM type_effectiveness WHERE atk_type = ? AND def_type = ?', (atk_type,
                                                                                                        def_type2))
        type_effect2 = my_cursor.fetchone()[0]
        my_cursor.execute('SELECT multiplier FROM type_interactions WHERE effect_1 = ? AND effect_2 = ?',
                          (type_effect1, type_effect2))
        final_effect = my_cursor.fetchone()[0]
        type_combo_name = ''
        my_cursor.execute('SELECT type_name FROM monster_types WHERE  id = ?', (def_type1,))
        type_combo_name += my_cursor.fetchone()[0]
        my_cursor.execute('SELECT type_name FROM monster_types WHERE  id = ?', (def_type2,))
        type_combo_name += '/' + my_cursor.fetchone()[0]
        print('The effect of a {} attack on a {} type monster would be {}'.format(atk_type_name,
                                                                                  type_combo_name, str(final_effect)));


if __name__ == '__main__':
    unittest.main()
