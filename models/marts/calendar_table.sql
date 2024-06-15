-- models/marts/calendar_table.sql

with date_spine as (
    select
        date_add('1970-01-01', interval day*1 day) as date
    from
        unnest(generate_array(0, 365*10)) as day
),

calendar as (
    select
        date,
        extract(year from date) as year,
        extract(month from date) as month,
        extract(day from date) as day,
        extract(dayofweek from date) as weekday,
        extract(quarter from date) as quarter,
        case when extract(dayofweek from date) in (1, 7) then true else false end as is_weekend
    from date_spine
)

select * from calendar
