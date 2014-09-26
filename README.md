### Drupal-Obfuscate 

Drupal database dump sanitization script for keeping sensitive data safe during data migration to development, testing or local boxes

Based on [MyObfuscate](https://github.com/mavenlink/my_obfuscate)  gem and it's dependencies 

### Requirements

* Ruby
* Bundler

### Install

  * Clone repository
  * Run `bundle install`

### Usage

MySQL database dump must be done with `-c` and `--hex-blob` options:

```
 mysqldump -c --add-drop-table --hex-blob -uDBUSER -pDBPASSWORD DBNAME | ruby drupal-obfuscate.rb > obfuscated_dump.sql
```

If you get MySQL errors due to very long lines, try some combination of `--max_allowed_packet=128M`, `--single-transaction`, `--skip-extended-insert`, and `--quick`

As result you will get obfuscated user passwords and emails

### Customization

#### Exclusions

Here is no modification done for users with UID equal to 0 (anonymous guest) and 1 (default superadmin)

Change `ingore_users` method to apply your own exclusion or create own other method

#### User password

By default, script set password as `password` string for all users
To set other password, run
```
php scripts/password-hash.sh 'ANY_OTHER_PASSWORD_STRING'
```
and copy-paste string to value of `USERS_PASSWORD` variable

#### Cache tables
Current script contain definitions for cache tables available with clean installation of `standard` Drupal profile

Add more `cache_` tables with `:truncate` option, if you have any

#### Other tables

Add any other tables required obfuscation with `:type` supported by [my_obfuscate](https://github.com/mavenlink/my_obfuscate)

#### LICENSE

This work is provided under the MIT License
