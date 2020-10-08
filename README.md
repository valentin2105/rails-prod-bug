# README

## Ruby version

- `ruby 2.7.1`

- `Rails 6.0.3`

## Configuration

- Global configuration on `config/application.yml`

- Tokens & Passwords on User's Database

> `RAILS_ENV` define the environment (dev / production)

## Database creation

DB configuration in `config/database.yml`

- export .env.{dev,production} and `rails db:prepare`


## How to download assets & gems

- `yarn install --check-files`
- `bundle`

## How to run the test suite

`rspec spec/models/*`


## Create a superadmin User

### Dev
```
export $(grep -v '^#' .env.dev | xargs ) && rails console
u=User.where(:email => 'email@domain.tld').first
u.superadmin_role=1
u.save
```

### Prod
```
=# UPDATE users SET superadmin_role = True  WHERE email='email@domain.tld';
```
## Dependencie
`sudo apt install  zlib1g-dev libpq-dev`

## Deployment instructions

In Dev :

`make {assets,migrate,dev}`

In Prod : 

`docker-compose up -d # After edit docker-compose.yml`

`docker-compose exec web bundle exec rails db:prepare`

Netbox VM's need to have 4 custom_fields : 

- `terraformable` (bool)

- `proxmoxvmid` (int)

- `proxmoxnode` (string)

- `proxmoxpool` (string)
