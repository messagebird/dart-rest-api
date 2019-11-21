import 'email.dart';
import 'message.dart';

/// Class encapsulating a [Content] object.
abstract class Content {
  /// Get a [Content] from [json] object based on [type].
  static Content get(MessageType type, Map<String, dynamic> json) {
    switch (type) {
      case MessageType.text:
        return TextContent(json['text'].toString());
      case MessageType.image:
        return ImageContent(Media.fromJson(json['image']));
      case MessageType.video:
        return VideoContent(Media.fromJson(json['video']));
      case MessageType.audio:
        return AudioContent(Media.fromJson(json['audio']));
      case MessageType.location:
        return LocationContent(Location.fromJson(json['location']));
      case MessageType.hsm:
        return HSMContent.fromJson(json['hsm']);
      case MessageType.email:
        return EmailContent(
            html: json['html']?.toString(), text: json['text']?.toString());
      default:
        return null;
    }
  }

  /// Get a json object representing the [Content]
  Map<String, dynamic> toJson();
}

/// Class encapsulating text content.
class TextContent extends Content {
  /// Required for type `text`. The plain-text content of the message.
  String text;

  /// Constructor.
  TextContent(this.text);

  @override
  Map<String, dynamic> toJson() => {'text': text.toString()};
}

/// Class encapsulating image content.
class ImageContent extends Content {
  /// Required for type `image`.
  Media image;

  /// Constructor.
  ImageContent(this.image);

  @override
  Map<String, dynamic> toJson() => image.toJson();
}

/// Class encapsulating audio content.
class AudioContent extends Content {
  /// Required for type `audio`.
  Media audio;

  /// Constructor.
  AudioContent(this.audio);

  @override
  Map<String, dynamic> toJson() => audio.toJson();
}

/// Class encapsulating video content.
class VideoContent extends Content {
  /// Required for type `video`.
  Media video;

  /// Constructor.
  VideoContent(this.video);

  @override
  Map<String, dynamic> toJson() => video.toJson();
}

/// Class encapsulating file content.
class FileContent extends Content {
  /// Required for type `file`.
  Media file;

  /// Constructor.
  FileContent(this.file);

  @override
  Map<String, dynamic> toJson() => file.toJson();
}

/// Class encapsulating location content.
class LocationContent extends Content {
  /// Required for type `location`.
  Location location;

  /// Constructor.
  LocationContent(this.location);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return null;
  }
}

/// Class encapsulating a location.
class Location {
  /// The latitude coordinates of the location.
  double latitude;

  /// The longitude coordinates of the location.
  double longitude;

  /// Constructor.
  Location(this.latitude, this.longitude);

  /// Construct a [Location] object from a [json] object.
  factory Location.fromJson(Map<String, dynamic> json) =>
      json == null ? null : Location(json['latitude'], json['longitude']);

  /// Get a json object representing the [Location]
  Map<String, dynamic> toJson() =>
      {'latitude': latitude, 'longitude': longitude};
}

/// Class encapsulating a highly structured message (HSM).
///
/// A HSM can only be sent over a WhatsApp channel, see
/// [HSM Messages for Whatsapp](https://developers.messagebird.com/api/conversations/#hsm-messages-for-whatsapp)
class HSMContent extends Content {
  /// Required. WhatsApp namespace for your account. You will receive this value
  /// when setting up your WhatsApp account.
  String namespace;

  /// Required. The name of the template.
  String templateName;

  /// Required.
  HSMLanguage language;

  /// Required.
  List<HSMLocalizableParameters> parameters;

  /// Constructor.
  HSMContent(this.namespace, this.templateName, this.language, this.parameters);

  /// Construct a [HSMContent] object from a [json] object.
  factory HSMContent.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : HSMContent(
          json['namespace'].toString(),
          json['templateName'].toString(),
          HSMLanguage.fromJson(json['language']),
          HSMLocalizableParameters.fromJsonList(json['parameters']));

  @override
  Map<String, dynamic> toJson() => {
        'namespace': namespace,
        'templateName': templateName,
        'language': language.toJson(),
        'parameters': parameters.map((parameter) => parameter.toJson()).toList()
      };
}

/// Class encapsulating the language of a highly structured message (HSM).
class HSMLanguage {
  /// Required. Possible values: `fallback` or `deterministic`. Deterministic
  /// will deliver the message template in exactly the language and locale asked
  /// for while fallback will deliver the message template in user's device
  /// language, if the settings can't be found on users device the fallback
  /// language is used.
  String policy;

  /// Required. The code of the language or locale to use, accepts both language
  /// and language_locale formats (e.g., `en` or `en_US`).
  String code;

  /// Constructor.
  HSMLanguage(this.policy, this.code);

  /// Construct a [HSMLanguage] object from a [json] object.
  factory HSMLanguage.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : HSMLanguage(json['policy'].toString(), json['code'].toString());

  /// Get a json object representing the [HSMLanguage]
  Map<String, dynamic> toJson() => {'policy': policy, 'code': code};
}

/// Class encapsulating the localizable HSM parameters.
///
/// Some of the template parameters related to date/time and currency are
/// localizable and can be displayed based on a customer's device language and
/// local preferences. Default values are used when localization fails.
class HSMLocalizableParameters {
  /// Required. Default value of the parameter, it is used when localization
  /// fails. The only field needed when specifying parameter value that doesn't
  /// require localization.
  String defaultValue;

  /// Can be present only if dateTime object is not present. An object of the
  /// form `{"currencyCode": "required string of ISO 4217 currency code", `
  /// `"amount": "required integer of total amount together with cents as a `
  /// `float, multiplied by 1000"}`
  Currency currency;

  /// Can be present only if currency object is not present. RFC3339
  /// representation of the date and time.
  DateTime dateTime;

  /// Constructor.
  HSMLocalizableParameters(this.defaultValue, {this.currency, this.dateTime}) {
    if (currency != null && dateTime != null) {
      throw Exception(
          'Arguments "currency" and "datetime" are mutually exclusive. '
          'Remove one of these arguments.');
    }
  }

  /// Construct a [HSMLocalizableParameters] object from a [json] object.
  factory HSMLocalizableParameters.fromJson(Map<String, dynamic> json) =>
      json == null
          ? null
          : HSMLocalizableParameters(json['defaultValue'].toString(),
              currency: Currency.fromJson(json['currency']),
              dateTime: DateTime.parse(json['dateTime'].toString()));

  /// Get a list of [HSMLocalizableParameters] objects from a [json] object
  static List<HSMLocalizableParameters> fromJsonList(Object json) =>
      json == null
          ? null
          : List.from(json)
              .map((j) => HSMLocalizableParameters.fromJson(j))
              .toList();

  /// Get a json object representing the [HSMLocalizableParameters]
  Map<String, dynamic> toJson() =>
      {'defaultValue': defaultValue, 'currency': currency.toJson()};
}

/// Class encapsulating the currency.
class Currency {
  /// Required. ISO 4217 currency code.
  String currencyCode;

  /// Required. Total amount together with cents as a float, multiplied by 1000.
  double amount;

  /// Constructor.
  Currency(this.currencyCode, this.amount);

  /// Construct a [Currency] object from a [json] object.
  factory Currency.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Currency(json['currencyCode'].toString(), double.parse(json['amount']));

  /// Get a json object representing the [Currency]
  Map<String, dynamic> toJson() =>
      {'currencyCode': currencyCode, 'amount': amount};
}

/// Class encapsulating a [Media] object.
class Media {
  /// The url of the remote media file.
  String url;

  /// The caption associated with the media file.
  String caption;

  /// Constructor.
  Media(this.url, {this.caption});

  /// Construct a [Media] object from a [json] object.
  factory Media.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Media(json['url'].toString(), caption: json['caption'].toString());

  /// Get a json object representing the [Media]
  Map<String, String> toJson() {
    Map<String, String> json;
    if (url != null) {
      json.addAll({'url': url.toString()});
    }
    if (caption != null) {
      json.addAll({'caption': caption.toString()});
    }
    return json;
  }
}
