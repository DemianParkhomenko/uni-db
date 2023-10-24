psql -f install.sql -U postgres
PGPASSWORD=demian psql -d uni_db -f structure.sql -U demian
PGPASSWORD=demian psql -d uni_db -f data.sql -U demian
