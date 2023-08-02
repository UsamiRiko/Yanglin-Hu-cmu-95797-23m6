select {{ dbt_utils.pivot(
        'borough',
        dbt_utils.get_column_values(ref('mart__fact_trips_by_borough'), 'borough'),
        agg='sum',
        then_value = 'trips_num',
        ) }}
from {{ ref('mart__fact_trips_by_borough') }}