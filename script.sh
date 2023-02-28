#!/bin/bash
################################ Orhma Company##################################
PGPASSWORD=password psql -U postgres -c "CREATE DATABASE temporary_database;"
PGPASSWORD=password psql -U postgres -d temporary_database < orhma_backup.sql

sql="SELECT role,COUNT(*) FROM users Group by role Order by role desc"
psql_output=$(PGPASSWORD=password psql -U postgres -d temporary_database -c "$sql")
readarray -t user_array <<<"$psql_output"
unset user_array[-1]

sql="SELECT * FROM clients WHERE company_name = 'ORHMA';"
psql_output=$(PGPASSWORD=password psql -U postgres -d billing_development -c "$sql")
readarray -t client_array <<<"$psql_output"
 
 old_ifs=$IFS
 IFS='|'
 read -r id name company_name address email created_at updated_at  <<< "${client_array[2]}"
 IFS=$old_ifs

 current_month=$(date +"%B")
 current_year=$(date +%Y)
 declare -A roles
 roles=([admin]=1 [super_admin]=2 [contact]=3 [technician]=4 [office_staff]=5 [sub_contractor]=6 [mechanic]=7 [dispacher]=8)
 
for element in "${user_array[@]:2}"
do
    old_ifs=$IFS
    IFS='|'
    read -r role users_nb  <<< "$element"

    VAR2="${role// /}"
    # VAR1="${r// /}"
    index=${roles[$VAR2]}
    if [ "$index" ]; then
        unset roles[$VAR2]
    fi
     

case "${role// /}" in
"admin")
user_role="Admin";;
"super_admin")
user_role="Super Admin";;
"contact")
user_role="Consumers";;
"technician")
user_role="Technician";;
"office_staff")
user_role="Office Staff";;
"sub_contractor")
user_role="Sub Contractor";;
"mechanic")
user_role="Mechanic";;
"dispacher")
user_role="Dispacher";;
esac

    
    IFS=$old_ifs
    sql="INSERT INTO users (user_type, user_rate, active_users,registered_users,month,year,client_id,created_at,updated_at)
VALUES ('$user_role', 20.5, $users_nb,$users_nb,'$current_month',$current_year,$id,'$created_at','$updated_at');"

    PGPASSWORD=password psql -U postgres -d billing_development -c "$sql"
done

# Rest of the empty roles
for r in ${!roles[@]}
do


case "${r// /}" in
"admin")
user_role="Admin";;
"super_admin")
user_role="Super Admin";;
"contact")
user_role="Consumers";;
"technician")
user_role="Technician";;
"office_staff")
user_role="Office Staff";;
"sub_contractor")
user_role="Sub Contractor";;
"mechanic")
user_role="Mechanic";;
"dispacher")
user_role="Dispacher";;
esac

    IFS=$old_ifs
    sql="INSERT INTO users (user_type, user_rate, active_users,registered_users,month,year,client_id,created_at,updated_at)
VALUES ('$user_role',0,0,0,'$current_month',$current_year,$id,'$created_at','$updated_at');"
    PGPASSWORD=password psql -U postgres -d billing_development -c "$sql"
done

PGPASSWORD=password psql -U postgres -c "DROP DATABASE temporary_database;"


################################ Eastwing Company##################################
PGPASSWORD=password psql -U postgres -c "CREATE DATABASE temporary_database;"
PGPASSWORD=password pg_restore -U postgres -d temporary_database -v eastwing_backup.tar

sql="SELECT role,COUNT(*) FROM users Group by role Order by role desc"
psql_output=$(PGPASSWORD=password psql -U postgres -d temporary_database -c "$sql")
readarray -t user_array <<<"$psql_output"
unset user_array[-1]

sql="SELECT * FROM clients WHERE company_name = 'Eastwing';"
psql_output=$(PGPASSWORD=password psql -U postgres -d billing_development -c "$sql")
readarray -t client_array <<<"$psql_output"
 
 old_ifs=$IFS
 IFS='|'
 read -r id name company_name address email created_at updated_at  <<< "${client_array[2]}"
 IFS=$old_ifs

 current_month=$(date +"%B")
 current_year=$(date +%Y)
 declare -A roles
 roles=([admin]=1 [super_admin]=2 [contact]=3 [technician]=4 [office_staff]=5 [sub_contractor]=6 [mechanic]=7 [dispacher]=8)
 
for element in "${user_array[@]:2}"
do
    old_ifs=$IFS
    IFS='|'
    read -r role users_nb  <<< "$element"

    VAR2="${role// /}"
    # VAR1="${r// /}"
    index=${roles[$VAR2]}
    if [ "$index" ]; then
        unset roles[$VAR2]
    fi
     

case "${role// /}" in
"admin")
user_role="Admin";;
"super_admin")
user_role="Super Admin";;
"contact")
user_role="Consumers";;
"technician")
user_role="Technician";;
"office_staff")
user_role="Office Staff";;
"sub_contractor")
user_role="Sub Contractor";;
"mechanic")
user_role="Mechanic";;
"dispacher")
user_role="Dispacher";;
esac

    
    IFS=$old_ifs
    sql="INSERT INTO users (user_type, user_rate, active_users,registered_users,month,year,client_id,created_at,updated_at)
VALUES ('$user_role', 20.5, $users_nb,$users_nb,'$current_month',$current_year,$id,'$created_at','$updated_at');"

    PGPASSWORD=password psql -U postgres -d billing_development -c "$sql"
done

# Rest of the empty roles
for r in ${!roles[@]}
do


case "${r// /}" in
"admin")
user_role="Admin";;
"super_admin")
user_role="Super Admin";;
"contact")
user_role="Consumers";;
"technician")
user_role="Technician";;
"office_staff")
user_role="Office Staff";;
"sub_contractor")
user_role="Sub Contractor";;
"mechanic")
user_role="Mechanic";;
"dispacher")
user_role="Dispacher";;
esac

    IFS=$old_ifs
    sql="INSERT INTO users (user_type, user_rate, active_users,registered_users,month,year,client_id,created_at,updated_at)
VALUES ('$user_role',0,0,0,'$current_month',$current_year,$id,'$created_at','$updated_at');"
    PGPASSWORD=password psql -U postgres -d billing_development -c "$sql"
done

PGPASSWORD=password psql -U postgres -c "DROP DATABASE temporary_database;"

################################ ID Mech Company##################################
PGPASSWORD=password psql -U postgres -c "CREATE DATABASE temporary_database;"
PGPASSWORD=password pg_restore -U postgres -d temporary_database -v idmech_backup.tar

sql="SELECT role,COUNT(*) FROM users Group by role Order by role desc"
psql_output=$(PGPASSWORD=password psql -U postgres -d temporary_database -c "$sql")
readarray -t user_array <<<"$psql_output"
unset user_array[-1]

sql="SELECT * FROM clients WHERE company_name = 'ID Mech';"
psql_output=$(PGPASSWORD=password psql -U postgres -d billing_development -c "$sql")
readarray -t client_array <<<"$psql_output"
 
 old_ifs=$IFS
 IFS='|'
 read -r id name company_name address email created_at updated_at  <<< "${client_array[2]}"
 IFS=$old_ifs

 current_month=$(date +"%B")
 current_year=$(date +%Y)
 declare -A roles
 roles=([admin]=1 [super_admin]=2 [contact]=3 [technician]=4 [office_staff]=5 [sub_contractor]=6 [mechanic]=7 [dispacher]=8)
 
for element in "${user_array[@]:2}"
do
    old_ifs=$IFS
    IFS='|'
    read -r role users_nb  <<< "$element"

    VAR2="${role// /}"
    # VAR1="${r// /}"
    index=${roles[$VAR2]}
    if [ "$index" ]; then
        unset roles[$VAR2]
    fi
     

case "${role// /}" in
"admin")
user_role="Admin";;
"super_admin")
user_role="Super Admin";;
"contact")
user_role="Consumers";;
"technician")
user_role="Technician";;
"office_staff")
user_role="Office Staff";;
"sub_contractor")
user_role="Sub Contractor";;
"mechanic")
user_role="Mechanic";;
"dispacher")
user_role="Dispacher";;
esac

    
    IFS=$old_ifs
    sql="INSERT INTO users (user_type, user_rate, active_users,registered_users,month,year,client_id,created_at,updated_at)
VALUES ('$user_role', 20.5, $users_nb,$users_nb,'$current_month',$current_year,$id,'$created_at','$updated_at');"

    PGPASSWORD=password psql -U postgres -d billing_development -c "$sql"
done

# Rest of the empty roles
for r in ${!roles[@]}
do


case "${r// /}" in
"admin")
user_role="Admin";;
"super_admin")
user_role="Super Admin";;
"contact")
user_role="Consumers";;
"technician")
user_role="Technician";;
"office_staff")
user_role="Office Staff";;
"sub_contractor")
user_role="Sub Contractor";;
"mechanic")
user_role="Mechanic";;
"dispacher")
user_role="Dispacher";;
esac

    IFS=$old_ifs
    sql="INSERT INTO users (user_type, user_rate, active_users,registered_users,month,year,client_id,created_at,updated_at)
VALUES ('$user_role',0,0,0,'$current_month',$current_year,$id,'$created_at','$updated_at');"
    PGPASSWORD=password psql -U postgres -d billing_development -c "$sql"
done

PGPASSWORD=password psql -U postgres -c "DROP DATABASE temporary_database;"
 