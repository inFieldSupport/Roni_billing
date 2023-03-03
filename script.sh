#!/bin/bash
################################ Orhma Company##################################
# Create temporary database
PGPASSWORD=password psql -U postgres -c "CREATE DATABASE temporary_database;"
# Restore data from Orhma backup
PGPASSWORD=password psql -U postgres -d temporary_database < orhma_backup.sql
# Get user count ordered by role
sql="SELECT role,COUNT(*) FROM users Group by role Order by role desc"
psql_output=$(PGPASSWORD=password psql -U postgres -d temporary_database -c "$sql")
# save result in user_array
readarray -t user_array <<<"$psql_output"
unset user_array[-1]
# Select client Orhma from the billing app database
sql="SELECT * FROM clients WHERE company_name = 'ORHMA';"
psql_output=$(PGPASSWORD=password psql -U postgres -d billing_development -c "$sql")
readarray -t client_array <<<"$psql_output"
 
 old_ifs=$IFS
 IFS='|'
 read -r id name company_name address email created_at updated_at  <<< "${client_array[2]}"
 IFS=$old_ifs

 current_month=$(date +"%B")
 current_year=$(date +%Y)
  #Create roles array
 declare -A roles

 roles=([admin]=1 [super_admin]=2 [contact]=3 [technician]=4 [office_staff]=5 [sub_contractor]=6 [mechanic]=7 [dispacher]=8)
 # Insert users into billing app
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

# Insert Rest of the empty roles
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
# Drop the temporary database
PGPASSWORD=password psql -U postgres -c "DROP DATABASE temporary_database;"
###################################################################################

################################ Eastwing Company##################################
# Create temporary database
PGPASSWORD=password psql -U postgres -c "CREATE DATABASE temporary_database;"
# Restore data from Eastwing backup
PGPASSWORD=password pg_restore -U postgres -d temporary_database -v eastwing_backup.tar
# Get user count ordered by role
sql="SELECT role,COUNT(*) FROM users Group by role Order by role desc"
psql_output=$(PGPASSWORD=password psql -U postgres -d temporary_database -c "$sql")
# save result in user_array
readarray -t user_array <<<"$psql_output"
unset user_array[-1]
# Select client Eastwing from the billing app database
sql="SELECT * FROM clients WHERE company_name = 'Eastwing';"
psql_output=$(PGPASSWORD=password psql -U postgres -d billing_development -c "$sql")
readarray -t client_array <<<"$psql_output"
 
 old_ifs=$IFS
 IFS='|'
 read -r id name company_name address email created_at updated_at  <<< "${client_array[2]}"
 IFS=$old_ifs

 current_month=$(date +"%B")
 current_year=$(date +%Y)
 #Create roles array
 declare -A roles
 roles=([admin]=1 [super_admin]=2 [contact]=3 [technician]=4 [office_staff]=5 [sub_contractor]=6 [mechanic]=7 [dispacher]=8)
 # Insert users into billing app
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

# Insert rest of the empty roles
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
# Drop temporary database
PGPASSWORD=password psql -U postgres -c "DROP DATABASE temporary_database;"
##################################################################################

################################ ID Mech Company##################################
# Create temporary database
PGPASSWORD=password psql -U postgres -c "CREATE DATABASE temporary_database;"
# Restore data from ID Mech backup
PGPASSWORD=password pg_restore -U postgres -d temporary_database -v idmech_backup.tar
# Get user count ordered by role
sql="SELECT role,COUNT(*) FROM users Group by role Order by role desc"
psql_output=$(PGPASSWORD=password psql -U postgres -d temporary_database -c "$sql")
# save result in user_array
readarray -t user_array <<<"$psql_output"
unset user_array[-1]
# Select client ID Mech from the billing app database
sql="SELECT * FROM clients WHERE company_name = 'ID Mech';"
psql_output=$(PGPASSWORD=password psql -U postgres -d billing_development -c "$sql")
readarray -t client_array <<<"$psql_output"
 
 old_ifs=$IFS
 IFS='|'
 read -r id name company_name address email created_at updated_at  <<< "${client_array[2]}"
 IFS=$old_ifs

 current_month=$(date +"%B")
 current_year=$(date +%Y)
 #Create roles array
 declare -A roles
 roles=([admin]=1 [super_admin]=2 [contact]=3 [technician]=4 [office_staff]=5 [sub_contractor]=6 [mechanic]=7 [dispacher]=8)
 # Insert users into billing app
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

# Insert rest of the empty roles
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
# Drop temporary database
PGPASSWORD=password psql -U postgres -c "DROP DATABASE temporary_database;"
##################################################################################
 