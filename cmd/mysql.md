# ubuntun
## install 
$ sudo apt install mysql-server mysql-client
## version
$ mysql --version
mysql  Ver 14.14 Distrib 5.7.27, for Linux (x86_64) using  EditLine wrapper
## status
$ sudo service mysql status
● mysql.service - MySQL Community Server
   Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2020-10-07 07:21:08 JST; 1 months 16 days ago
 Main PID: 1446 (mysqld)
    Tasks: 28 (limit: 4915)
   CGroup: /system.slice/mysql.service
           mq1446 /usr/sbin/mysqld --daemonize --pid-file=/run/mysqld/mysqld.pid

Oct 07 07:21:07 ubuntu systemd[1]: Starting MySQL Community Server...
Oct 07 07:21:08 ubuntu systemd[1]: Started MySQL Community Server.
## installation
$ sudo mysql_secure_installation

Securing the MySQL server deployment.

Connecting to MySQL using a blank password.

VALIDATE PASSWORD PLUGIN can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD plugin?

Press y|Y for Yes, any other key for No: y

There are three levels of password validation policy:

LOW    Length >= 8
MEDIUM Length >= 8, numeric, mixed case, and special characters
STRONG Length >= 8, numeric, mixed case, special characters and dictionary                  file

Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG: 0
Please set the password for root here.

New password:

Re-enter new password:

Estimated strength of the password: 50
Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : y
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) : y
Success.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y
 - Dropping test database...
Success.

 - Removing privileges on test database...
Success.

Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y
Success.

All done!
## mysql 
$ sudo mysql -u root
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 5.7.27-0ubuntu0.18.04.1 (Ubuntu)

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
## SHOW VARIABLES LIKE 'validate_password%';
mysql> SHOW VARIABLES LIKE 'validate_password%';
+--------------------------------------+-------+
| Variable_name                        | Value |
+--------------------------------------+-------+
| validate_password_check_user_name    | OFF   |
| validate_password_dictionary_file    |       |
| validate_password_length             | 8     |
| validate_password_mixed_case_count   | 1     |
| validate_password_number_count       | 1     |
| validate_password_policy             | LOW   |
| validate_password_special_char_count | 1     |
+--------------------------------------+-------+
7 rows in set (0.00 sec)
## 
mysql> set global validate_password_length=5;
Query OK, 0 rows affected (0.00 sec)
## 
mysql> set global validate_password_policy=LOW;
## add user     ★★
mysql> CREATE USER 'ユーザー名'@'ホスト名' IDENTIFIED BY 'パスワード';
##
mysql> select user,host from mysql.user;

## 
mysql> GRANT all ON [DB or Table] TO 'ユーザー名'@'ホスト名';
mysql> GRANT all ON *.* TO 'houtarou'@'localhost';
Query OK, 0 rows affected (0.00 sec)

## 
mysql> SHOW GRANTS FOR 'houtarou'@'localhost';
+-------------------------------------------------------+
| Grants for houtarou@localhost                         |
+-------------------------------------------------------+
| GRANT ALL PRIVILEGES ON *.* TO 'houtarou'@'localhost' |
+-------------------------------------------------------+
1 row in set (0.00 sec)
## 
DROP USER 'ユーザー名'@'ホスト名';

## DBファイルの保存先
mysql> SELECT @@datadir;
## timezone
mysql> SHOW VARIABLES LIKE '%time_zone%';
+------------------+--------+
| Variable_name    | Value  |
+------------------+--------+
| system_time_zone | JST    |
| time_zone        | SYSTEM |
+------------------+--------+
2 rows in set (0.01 sec)

mysql> SELECT @@system_time_zone, @@session.time_zone;
+--------------------+---------------------+
| @@system_time_zone | @@session.time_zone |
+--------------------+---------------------+
| JST                | SYSTEM              |
+--------------------+---------------------+
1 row in set (0.00 sec)
## 
mysql> show global variables like '%timeout%';
## 全部の変数を表示　   ★★
SHOW VARIABLES;

## SQLモード
mysql> SELECT @@GLOBAL.sql_mode;
+----------------------------------------------------------------+
| @@GLOBAL.sql_mode                                              |
+----------------------------------------------------------------+
| STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION |
+----------------------------------------------------------------+
1 row in set (0.00 sec)
    # Set the SQL mode to strict
sql-mode="STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"

## 配置ファイルの保存先
/var/run/mysqld/mysqld.sock
## 起動、停止、再起動
mysql> mysql.server start
mysql> mysql.server stop
mysql> mysql.server restart


## connect
　　　 mysqladmin --host=192.168.10.100 shutdown
        mysql -u root -h 192.168.11.4

##
service mysql status
/etc/init.d/mysqld status
/etc/init.d/mysqld start
/etc/init.d/mysqld stop
/etc/init.d/mysqld restart

