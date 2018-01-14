# dockerized-phabricator

## how to up

```bash
$ ./build.bash
$ ./up.bash
```

and 

## access containers

use _core_, _web_, _db_ as $CONTAINER

```bash
$ ./ssh.bash $CONTAINER
```

## how to init

### access to _core_

```bash
./ssh.bash core
```

### config phabricator from _core_

```bash
cd phabricator/
./bin/phd stop
./bin/config set mysql.host db
./bin/config set mysql.port 3306
./bin/config set mysql.user root
./bin/config set mysql.pass ""
./bin/storage upgrade
./bin/phd start
./bin/config set phabricator.base-uri 'http://0.0.0.0/'
./bin/config set pygments.enabled true
./bin/config set pygments.enabled true --database
./bin/config set phabricator.timezone "Asia/Ho_Chi_Minh"
./bin/config set phabricator.timezone "Asia/Ho_Chi_Minh" --database
```

### access http://0.0.0.0/ from browser and create admin account