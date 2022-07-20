select *
from {{ source('main', 'sample_data') }}
