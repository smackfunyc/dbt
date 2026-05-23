{% macro get_day_type(date_column) %}

    case
        when dayname({{ date_column }}) in ('Sat', 'Sun')
            then 'WEEKEND'
        else 'BUSINESSDAY'
    end

{% endmacro %}