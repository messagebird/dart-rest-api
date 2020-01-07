# MessageBird REST API library for Dart
This repository provides a Dart client for MessageBird's REST API. Documentation can be found at: https://developers.messagebird.com.

## Requirements
- [Sign up](https://www.messagebird.com/en/signup) for a free MessageBird account
- Create a new `access_key` in the [developers](https://www.messagebird.com/app/en/settings/developers/access) section

## Installation
Add the following code to your `pubspec.yaml` file:

```yaml
dependencies:
  messagebird:
    git:
      url: https://github.com/messagebird/dart-rest-api.git
      version: ^1.2.0
```

## Usage
First initialize the library in your code. Then, an API from the `messagebird` package can be accessed by initializing a service with your API key.

## Example
See `example/main.dart`

```dart
import 'dart:io';

import 'package:messagebird/balance.dart';

void main() {
  final BalanceService balanceService = ApiBalanceService('YOUR_KEY_HERE');
  balanceService.read().then((balance) {
    stdout.write('My balance is ${balance.amount}');
    exit(0);
  });
}
```

## Conversations Whatsapp Sandbox
To use the whatsapp sandbox you need to add `"ENABLE_CONVERSATIONSAPI_WHATSAPP_SANDBOX"` to the list of features you want enabled in `ApiConversationService` (named parameter `features` in the constructor).

## Generate documentation
Documentation for this repository can be generated using the `dartdoc` command. After running the command, the documentation files can be found in `doc/api`. More information about dartdoc can be found in the official dartdoc [documentation](https://dart.dev/tools/dartdoc).

## Tests
This repository includes unit tests, located in the `test` directory. To run them, execute `pub run test` in the command line. Covered are, per service, service tests and json (de)serialization tests of data classes.

Before running the tests, create a `keys.json` file in `test_resources/` with the following content:
```json
{
    "test": "YOUR_API_TEST_KEY",
    "live": "YOUR_API_LIVE_KEY",
    "msisdn": "YOUR_MSISDN"
}
```

**Please note**: when running the tests, your MessageBird account will be charged a small amount to test sending calls and messages.

## Acknowledgements
This library was initially developer by [@lucvanderzandt](https://github.com/lucvanderzandt) while working at [@Drillster](https://github.com/Drillster). ❤️

## License
The MessageBird REST API for Dart is licensed under [The BSD 3-Clause License](http://opensource.org/licenses/BSD-3-Clause). Copyright (c) 2019, MessageBird B.V. 
