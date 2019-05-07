# LogParser

A small lib to parse simple log files.
 
Each lines is formatted as `<url> <ip>`.

Example:
```text
/help_page/1 126.318.035.038
/contact 184.123.665.067
/home 184.123.665.067
```

## Install

Requirements:
- ruby 2.6.1 (tested on it)

```bash
gem install bundler
bundle install
```

## Run

```bash
bundle exec ruby bin/parser.rb webserver.log
```

If you have needed gems installed locally you may run it as a script:
```bash
chmod +x bin/parser.rb
bin/parser.rb webserver.log
```

## Tests

To run tests type
```bash
bundle exec rake test
```