{%- set patterns = [
    ('T_DOSAGE', '^((?:((?:-)?(?:\d+)(?:\.)?(?:\d*)|(?:-)?(?:\d*)(?:\.)?(?:\d+)))(?: )?(?:(GRAMS|MILIGRAMS|G|MILLIGRAMS|MG|MICROGRAMS|MCG|LITERS|LITRES|L|MILLILITERS|MILILITERS|MILLILITRES|MILILITRES|ML|DECILITERS|DECILITRES|DL)))'),
    ('T_NUMERIC', '^((?:-)?(?:\d+)(?:\.)?(?:\d*)|(?:-)?(?:\d*)(?:\.)?(?:\d+))'),
    ('T_WORD', '^[A-Z\-]+'),
    ('T_IGNORE', '^[ ,\(\)_]'),
    ('T_DEFAULT', '^.')
] -%}

{{ lex_table_column(source('main', 'sample_data'), 'DRUG_NAME', patterns) }}