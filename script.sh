#!/bin/bash

################################ ORHMA Company##################################
psql -U postgres -c "CREATE DATABASE temporary_database;"
psql -U postgres -d temporary_database < orhma_backup.sql 

sql="SELECT role,COUNT(*) FROM users Group by role"
psql_output=$(psql -U postgres -d temporary_database -c "$sql")
readarray -t user_array <<<"$psql_output"
unset user_array[-1]

sql="SELECT * FROM clients WHERE company_name = 'ORHMA';"
psql_output=$(psql -U postgres -d billing_development -c "$sql")
readarray -t client_array <<<"$psql_output"
 
 old_ifs=$IFS
 IFS='|'
 read -r id name company_name address email created_at updated_at  <<< "${client_array[2]}"
 IFS=$old_ifs

 current_month=$(date +"%B")
 current_year=$(date +%Y)
echo 
for element in "${user_array[@]:2}"
do


echo "$role"
case "${role// /}" in
"admin")
user_role="Admin";;
"super_admin")
user_role="Super Admin";;
"contact")
user_role="Consumers";;
*)
user_role="Consumers";;
esac
echo "$user_role"
    old_ifs=$IFS
    IFS='|'
    read -r role users_nb  <<< "$element"
    IFS=$old_ifs
    sql="INSERT INTO users (user_type, user_rate, active_users,registered_users,month,year,client_id,created_at,updated_at)
VALUES ('$user_role', 20.5, $users_nb,$users_nb,'$current_month',$current_year,$id,'$created_at','$updated_at');"

    psql -U postgres -d billing_development -c "$sql"
done

psql -U postgres -c "DROP DATABASE temporary_database;"