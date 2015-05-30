# Jenkins + Pivotal Release Notes

Generates release notes from Pivotal Tracker

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jenkins_pivotal_release_notes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jenkins_pivotal_release_notes

## Usage

In Jenkins, add a post build step like:

```
jenkins_pivotal --token a1b2c3 --project 1234 --date 05/01/2015 --file /Users/username/release_notes.txt
```

Help output is as follows.

```
Usage: bin/jenkins_pivotal_release_notes [options...]
    -t, --token        Tracker API token.
    -p, --project      Tracker Project ID.
    -d, --date         Story fetch date
    -f, --file         Saved file path
    -v, --version      Display version information.
    -h, --help         Display this help message.
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jenkins_pivotal_release_notes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
