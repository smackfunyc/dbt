-- macros/get_season.sql

{% macro get_season(date_column) %}

    case
        when month({{ date_column }}) in (12, 1, 2)
            then 'WINTER'
        when month({{ date_column }}) in (3, 4, 5)
            then 'SPRING'
        when month({{ date_column }}) in (6, 7, 8)
            then 'SUMMER'
        else 'AUTUMN'
    end

{% endmacro %}