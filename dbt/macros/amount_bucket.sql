{% macro amount_bucket(column) %}
case when {{ column }} >= 1000 then 'large' else 'regular' end
{% endmacro %}
