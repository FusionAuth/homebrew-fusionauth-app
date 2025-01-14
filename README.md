# homebrew-fusionauth
macOS [Homebrew](https://brew.sh/) tap for FusionAuth

Easy installation of FusionAuth via Homebrew.

Simply install and start the services. Then navigate to http://localhost:9011 and follow the setup prompts.

The following examples assume you will be installing `fusionauth-app`.

## Install

```bash
brew tap fusionauth/fusionauth
brew install fusionauth-app
```

## Start

```bash
brew services start fusionauth-app
```

## Upgrade

```bash
brew upgrade fusionauth-app
```

## Config

Logs: `/usr/local/var/log/fusionauth/`
Config file: `/usr/local/etc/fusionauth/fusionauth.properties`

## Test
If fusionauth is already installed via homebrew, you need to uninstall it.
    
```bash
brew uninstall fusionauth-app
```

Then to test that this works, run the following command from this diretory:

```bash
brew install ./Formula/fusionauth-app.rb
```

## Release

Using Savant
```bash
sb publish
```

Without using Savant
```bash
./publish.sh <version>
```
