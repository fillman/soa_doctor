# Healthcheck

In software oriented architecture happens that you have a lot of services.
They can crash sometimes on Heroku or else where you host them. This gem will help to quickly check their heart beat.

## Installation

    $ gem install soa_doctor

## Usage
If you install the gem it'll give the executable:
    $ healthcheck --help

For example you have YAML file with your services listed:

    ```ruby
        services:
          google: "http://google.com"
          yahoo:  "http://yahoo.com"
          yandex: "http://yandex.com"
    ```

So you do
    $ healthcheck -f you_yaml_file.yaml

The output would be a table or services and their statuses.

P.S: One more note, since soa_doctor uses escort it stores a ~/.healthcheck file at your home dir. It looks like this:

```json
{
  "global": {
    "options": {
      "file": null,
      "config": null,
      "verbosity": "WARN",
      "error_output_format": "basic"
    },
    "commands": {
      "escort": {
        "options": {
          "create_config": null,
          "create_default_config": null,
          "update_config": null,
          "update_default_config": null
        },
        "commands": {
        }
      }
    }
  },
  "user": {
  }
}

```

You can modify the file dir so it'll pick it up as default. So you can run simply:
$ healthcheck
And get the desired output.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
