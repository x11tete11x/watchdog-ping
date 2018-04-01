# watchdog-ping
A tiny script to watch if some IP is alive

Requirements:
1) A working DB, in my case i use MariaDB.
You need to create the following database:

```SQL
CREATE DATABASE <DBNAME>;
USE <DBNAME>;
CREATE TABLE ping(id INT unsigned NOT NULL AUTO_INCREMENT, ip VARCHAR(15), status VARCHAR(10), tx INT UNSIGNED, rx INT UNSIGNED, percent_lost INT UNSIGNED, min FLOAT, avg FLOAT, max FLOAT, mdev FLOAT, PRIMARY KEY (id),ts timestamp default current_timestamp);
```
2) If you need mail notify, you need to configure it and replace it in the code of the script

Install:
1) Clone it:
```GIT
git clone https://github.com/x11tete11x/watchdog-ping.git
```

2) Make executable 
```BASH
chmod +x /path/to/script/watchdog-ping.sh
```

3) You can put in cron, to execute periodically, for example every 5 minutes
```BASH
crontab -e
*/5 * * * * /path/to/script/watchdog-ping.sh
```
