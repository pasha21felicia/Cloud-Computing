# Cloud-Computing

## Application

Here are the microservices, for now defined in the docker compose file. 
In total 5 microservices, each in a separate folder (besides adminer):
- authentification
- backend
- frontend
- mysql_articles
- adminer

In README.md from Application folder are instructions how to setup the project locally and through docker compose.

### The Database
Is mysql, simple with 2 tables, Articles and Users, not connected through any foreign key, I want to add it later.

## Infrastructure

Ce am folosit eu la licenta, puteti sa vedeti ca exemplu de cum se fac deployments si service files in ./eks si 
in ./terraform cum se creaza modulele de terraform si lucru cu outputs.tf, variable.tf care se transmit intre module.
Cred ca faceti o copie locala la ce e aici si dupa rescriem pe el.