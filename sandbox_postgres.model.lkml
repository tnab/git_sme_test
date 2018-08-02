connection: "postgresql_gcp"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: sandbox_postgres_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sandbox_postgres_default_datagroup

explore: all_types {}
#
# explore: derived_test_base {
#   label: "Joined"
#   join: derived_test_B {
#     sql_on: derived_test_B.id = ${derived_test_base.id}
#     ;;
#   }
# }

explore: joined {
  from: derived_table_A
  join: derived_table_B {
    sql_on: ${derived_table_B.user_id} = ${joined.id} ;;
    relationship: one_to_one
  }
}

explore: derived_table_A {}

explore: derived_table_B {}

explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {}
