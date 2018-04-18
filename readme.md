# VVV Teamdrop

Export/import database and uploads from/to a [VVV site]() using a shared Dropbox folder. Handy for sharing database and media between a team during development.

![vvv-teamdrop](https://user-images.githubusercontent.com/307676/38929454-9cd40136-430c-11e8-9d90-e16a29aef9ea.png)

### Prerequisites

+ A shared [Dropbox](https://www.dropbox.com) folder
+ [VVV](https://github.com/Varying-Vagrant-Vagrants/VVV)
+ A WordPress site already setup, preferably using [Bedrock](https://roots.io/bedrock/).

## Getting Started

+ Copy db-export.sh and `db-import.sh` to your project root folder
+ Update your `.env` file with the following variables. (Also see `.env-example`)

```shell
VVV_IP=192.168.50.4
PROJECT_PATH="/Users/myusername/projects/projectfolder/"
VVV_PATH="/srv/www/projectfolder/htdocs"
DROPBOX_PATH="/Users/myusername/Dropbox/foldername/"
SQL_FILENAME="projectname"
INCLUDE_UPLOADS_IN_EXPORT=true
UPLOADS_PATH="web/app/uploads"
```

### Export

	./db-export

The following files will be added to the shared Dropbox folder.

+ projectname.sql
+ projectname-uploads.zip

### Import

	./db-import.sh

This script will use the files in the shared Dropbox folder, then login in to your VVV Vagrant box via ssh and import the `.sql` file and the `uploads` in the correct folder.

## Authors

**Urban Sanden** - [Urban Sanden](https://github.com/urre)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
