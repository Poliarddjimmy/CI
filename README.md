# CONTACT IMPORTER

## Quick Instructions

### Requirements

You need to have the following tools with the stated version to be able to properly run this application:

- ruby v2.6.4 & rails v6.1.4
- sqlite3 v1.4
- sidekiq
- redis

### Description

The application allow users to upload contact files in CSV format and process them in order to generate a unified contact file. Each contact is associated with the user who imported them into the platform. When uploading the files, the application validate that the fields entered are correctly formatted.

#### validation rull for the csv file

the header of the file must contain these headers in any order:

```
['name', 'email', 'phone', 'address', 'dob', 'credit_card']
```

#### name

Names with special characters, except for the minus(-) will be invalid values and cannot be saved.

#### dob

The system accept two types of ISO 8601 date formats (%Y%m%d ) and (%F). Any date that does not have these formats will not be saved

#### email

must have a valid email format and it can’t be repeated per associated account. This means that user A can have a contact example@gmail.com and

#### phone

Valid phone formats are (+00) 000 000 00 00 00, for example (+57) 320 432 05 09. And (+00) 000-000-00-00, for example (+57) 320-432-05-09. Any number that does not comply with this format should be ignored.

#### address

for the address there’s nothing to validate other than it’s not empty

#### credit_card

credit_card will receive number form 10 to 19 characters

#### all this field are require, else, the contact will not save in the system

### Setup Steps

After installing all the requirements above, here are the steps to run this application locally:

1. Clone this repository:

```
   git clone git@github.com:Poliarddjimmy/contact-importer.git
```

2. install all dependencies:

```
   bundle install
```

3. setup the db:

```
   rails db:setup or rails db:create && rails db:migrate && rails db:seed
```

4. start redis:

```
   sudo redis-server /usr/local/etc/redis.conf
```

5. start sidekiq:

```
   bundle exec sidekiq
```

6. lunch the application by running:

```
   rails s
```

### login

login by using: `email: test@test.test` and `password: password`

# GOOD LUCK
