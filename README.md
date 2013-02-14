Sinatra-springboard
===================

This application is an attempt at creating a basic starting point for app development of full-stack applications. It will try to generalize as much as possible but in specifics will cater to my personal development needs. I will try to keep the springboard as easy as possible to install but requirements are going to include ruby, rubygems and bundler and a number of gems.
Hopefully it will still be fairly installable, modular and maintainable.

##Installation
```bash
git clone https://github.com/PabloK/Sinatra-springboard.git
cd Sinatra-springboard
bundle install
```

##Running the server
```bash
rackup
```

##Usage
Place your controlers in lib/controlers and map them to a url in the config.ru file. Data models are placed in the lib models directory and can be used to create presistant storage using the datamapper API. To use this you need to configure a database and modify database configuration in config/environment.rb. Email is also configurable in environment.rb. Global variables can be configured in config/globals.conf. Sinatra helpers can be configured in conf/helpers.rb. Tests are executed trough the use of the following command
```bash
rake spec
```
Tests are located in separate folders inside the specfolder. Tests are configured in the spec/spec_helper.rb file. Html views are placed in the views directory where the main layout file layout.haml also exists.
Coffeescript & Sass files are converted by their respective controlers found in the lib/controler folders. .coffee and .sass files belong in the assets/js & assets/css folders respectivley.
Configuration of publicfolders is done in the config.ru file and starts with configuring audio and images to be located in the public folder in respective subfolder. robots.txt is also configured here.

For full feature the following environment variables needs to be configured. Preferably in your .baschrc file.
```bash
# Postgres is just an example and comes preconfigured some changes are needed in conf/environment.rb to use MYSQL or Sqlite
export DATABASE_URL="postgres://user:password@host/datbase"
export SESSION_SECRETE=""
#The following is just for sendgrid users
export SENDGRID_PASSWORD=""
export SENDGRID_USERNAME=""
```
