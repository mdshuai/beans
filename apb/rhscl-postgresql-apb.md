```
docker run -e "OPENSHIFT_TARGET=https://<master>:8443" -e "OPENSHIFT_USER=admin" \
       -e "OPENSHIFT_PASS=admin" ansibleplaybookbundle/rhscl-postgresql-apb provision \
       --extra-vars 'namespace=postgresql' --extra-vars 'postgresql_database=admin' \
       --extra-vars 'postgresql_password=admin' --extra-vars 'postgresql_user=admin' \
       --extra-vars 'postgresql_version=9.5'
````
