view: derived_table_B {
  derived_table: {
# persist_for: "24 hours"
  sql:
        WITH o_rank AS (
        SELECT
        user_id AS user_id,
        orders.id AS order_id,
        count(orders.id) AS count_orders,
        rank() over (order by count(orders.id) DESC) AS order_rank
        FROM public.orders AS orders
        GROUP BY 1,2
        )

        SELECT
        user_id,
        order_id,
        count_orders,
        order_rank
        FROM o_rank
        GROUP BY 1,2,3,4
        ;;
}

dimension: user_id {}

dimension: order_id {
  primary_key: yes
}

dimension: order_rank {}

dimension: count_orders {}


}
