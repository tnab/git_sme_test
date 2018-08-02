view: derived_table_A{
  derived_table: {
    persist_for: "24 hours"
    indexes: ["id"]
    sql:
        WITH ranking AS (
        SELECT
        age AS age,
        id AS id,
        count(id) AS count_users,
        rank() over (partition by age order by count(id) DESC) AS rank
        FROM public.users AS users
        GROUP BY 1,2
        )

        SELECT
        age,
        id,
        count_users,
        rank
        FROM ranking
        GROUP BY 1,2,3,4
        ;;
  }

  dimension: age {}

  dimension: id {
    primary_key: yes
  }

  dimension: count_users {}

  dimension: rank {}

#   dimension: sum_id {}


}
