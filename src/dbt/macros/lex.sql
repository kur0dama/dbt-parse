{% macro lex_table_column(tbl, col, patterns, maxiters = 100) %}
with iter_0_advance as (
    select
        {{col}} as orig_string,
        upper({{col}}) as unconsumed_string,
        0 as token_seq,
        null as token_type,
        null as token_string
    from
        {{tbl}}
    group by
        {{col}}
)

{% for i in range(1,maxiters) %}
, iter_{{i}}_gettoken as (
    select
        orig_string,
        unconsumed_string,
        {{i}} as token_seq,
        coalesce(
            {% for token, pattern in patterns %}
            case
                when regexp_extract(unconsumed_string, '{{pattern}}') <> '' 
                then '{{token}}'
                else null
            end
            {% if not loop.last %},{% endif %}
            {% endfor %}
        ) as token_type,
        coalesce(
            {% for token, pattern in patterns %}
            case
                when regexp_extract(unconsumed_string, '{{pattern}}') <> '' 
                then regexp_extract(unconsumed_string, '{{pattern}}')
                else null
            end{% if not loop.last %},{% endif %}
            {% endfor %}
        ) as token_string
    from
        iter_{{i-1}}_advance
)

, iter_{{i}}_advance as (
    select
        orig_string,
        substr(
            unconsumed_string, 
            strlen(token_string) + 1, 
            strlen(unconsumed_string) - strlen(token_string) + 1
        ) as unconsumed_string,
        token_seq,
        token_type,
        token_string
    from
        iter_{{i}}_gettoken
)

{% endfor %}

, union_tokens as (
    {% for i in range(1,maxiters) %}
    select
        orig_string,
        token_seq,
        token_type,
        token_string
    from 
        iter_{{i}}_advance
    {% if not loop.last %}
    union all
    {% endif %}
    {% endfor %}
)

select * from union_tokens
{% endmacro %}