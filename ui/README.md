# Setup

### OSX
Run the following commands in your Terminal:
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install chromedriver
$ brew install ruby-install
$ ruby-install ruby 2.3.1
$ brew install chruby
$ echo 'source /usr/local/opt/chruby/share/chruby/chruby.sh' >> ~/.bash_profile
$ echo "chruby ruby-2.3.1" >> ~/.bash_profile
$ source ~/.bash_profile
$ ruby -v #If everything installed properly this will be displayed ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]
$ gem install bundler
$ bundle install
```

### OSX (Docker)
Download and install [Docker](https://www.docker.com/community-edition#/download)

# Run Tests 
### without docker
```
$ cd test-automation/ui
bundle exec rspec spec/web                                   # run without test run
TESTRUNID='BBQ-R43' bundle exec rspec spec/web               # run with test run 
TESTRUNID='BBQ-R43' bundle exec rspec spec/web/login_spec.rb # run specific test with test run
```

### with docker
```
cd test-automation/ui
docker build -t bb_ui . # need to be run everytime if the code in test-automation/ui is updated

# run without test run and all tests
docker run -i --network=host \
--add-host 'local.beautyboutique.ca local.galeriebeaute.ca':$(ifconfig en0 | awk '$1 == "inet" {print $2}') \
bb_ui
 
# run with test run and all tests
docker run -i --network=host \
-e TESTRUNID='BBQ-R43' \
--add-host 'local.beautyboutique.ca local.galeriebeaute.ca':$(ifconfig en0 | awk '$1 == "inet" {print $2}') \
bb_ui
 
# run with test run and specific test
docker run -i --network=host \
-e TESTRUNID='BBQ-R43' \
-e TESTS='spec/web/login_spec.rb' \
--add-host 'local.beautyboutique.ca local.galeriebeaute.ca':$(ifconfig en0 | awk '$1 == "inet" {print $2}') \
bb_ui 
 
```


