# middlesite

[![Gem Version](https://badge.fury.io/rb/middlesite.png)](http://badge.fury.io/rb/middlesite)

> Gem containing tasks to build, release and deploy your Middleman site.

## Installation

```
$ gem install middlesite
```
## Usage

This tool requires a `site.yml` file in the `data` directory:

```
.
├── Gemfile
├── README.md
├── config.rb
├── data
│   └── site.yml
└── source
```
The `site.yml` file should contain the variable `version` which can be used in your templates as well:

```
---
version: 0.1.0
```

The following tasks are available trough the command line.

```
Commands:
  middlesite build           # Generate build from sources
  middlesite bump [TYPE]     # Bump version (patch|minor|major), commit, tag, and push.
  middlesite deploy          # Build and deploy to server
  middlesite help [COMMAND]  # Describe available commands or one specific command
  middlesite init            # Initialize the workspace.
  middlesite server          # Build and start server
```

## Development

When developing you can use the given `rake` tasks:

```
$ rake -T
rake build    # Build middlesite-0.1.1.gem into the pkg directory.
rake install  # Build and install middlesite-0.1.1.gem into system gems.
rake release  # Create tag v0.1.1 and build and push middlesite-0.1.1.gem to Rubygems```
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
Copyright (c) 2013 franklin under the MIT license.
