import 'dart:convert';

import '../util.dart';
import 'email.dart';
import 'message.dart';

/// Class encapsulating audio content.
class AudioContent extends Content {
  /// Required for type `audio`.
  final Media audio;

  /// Constructor.
  const AudioContent(this.audio);

  @override
  String toJson() => audio.toJson();

  @override
  Map<String, dynamic> toMap() => audio.toMap();
}

/// Class encapsulating a [Content] object.
abstract class Content {
  /// Constructor.
  const Content();

  /// Get a json [String] representing the [Content]
  String toJson();

  /// Get a [Map] representing the [Content]
  Map<String, dynamic> toMap();

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
        return EmailContent(html: json['html'], text: json['text']);
      default:
        return null;
    }
  }
}

/// Class encapsulating the currency.
class Currency {
  /// Required. ISO 4217 currency code.
  final String currencyCode;

  /// Required. Total amount together with cents as a float, multiplied by 1000.
  final double amount;

  /// Constructor.
  const Currency({
    this.currencyCode,
    this.amount,
  });

  /// Construct a [Currency] object from a json [String].
  factory Currency.fromJson(String source) =>
      Currency.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Currency] object from a [Map].
  factory Currency.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Currency(
          currencyCode: map['currencyCode'],
          amount: double.parse(map['amount'].toString()),
        );

  /// Get a json [String] representing the [Currency] object.
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'currencyCode': currencyCode,
        'amount': amount,
      };
}

/// Class encapsulating file content.
class FileContent extends Content {
  /// Required for type `file`.
  final Media file;

  /// Constructor.
  const FileContent(this.file);

  @override
  String toJson() => file.toJson();

  @override
  Map<String, dynamic> toMap() => file.toMap();
}

/// Class encapsulating a highly structured message (HSM).
///
/// A HSM can only be sent over a WhatsApp channel, see
/// [HSM Messages for Whatsapp](https://developers.messagebird.com/api/conversations/#hsm-messages-for-whatsapp)
class HSMContent extends Content {
  /// Required. WhatsApp namespace for your account. You will receive this value
  /// when setting up your WhatsApp account.
  final String namespace;

  /// Required. The name of the template.
  final String templateName;

  /// Required.
  final HSMLanguage language;

  /// Required.
  final List<HSMLocalizableParameters> parameters;

  /// Constructor
  const HSMContent({
    this.namespace,
    this.templateName,
    this.language,
    this.parameters,
  });

  /// Construct an [HSMContent] object from a json [String].
  factory HSMContent.fromJson(String source) =>
      HSMContent.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [HSMContent] object from a [Map].
  factory HSMContent.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : HSMContent(
          namespace: map['namespace'],
          templateName: map['templateName'],
          language: HSMLanguage.fromMap(map['language']),
          parameters: HSMLocalizableParameters.fromList(map['parameters']),
        );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
        'namespace': namespace,
        'templateName': templateName,
        'language': language.toMap(),
        'parameters': List<dynamic>.from(
            parameters.map((parameter) => parameter.toMap())),
      };
}

/// Class encapsulating the language of a highly structured message (HSM).
class HSMLanguage {
  /// Required. Possible values: `fallback` or `deterministic`. Deterministic
  /// will deliver the message template in exactly the language and locale asked
  /// for while fallback will deliver the message template in user's device
  /// language, if the settings can't be found on users device the fallback
  /// language is used.
  final String policy;

  /// Required. The code of the language or locale to use, accepts both language
  /// and language_locale formats (e.g., `en` or `en_US`).
  final String code;

  /// Constructor.
  const HSMLanguage({
    this.policy,
    this.code,
  });

  /// Construct an [HSMLanguage] object from a json [String].
  factory HSMLanguage.fromJson(String source) =>
      HSMLanguage.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [HSMLanguage] object from a [Map].
  factory HSMLanguage.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : HSMLanguage(
          policy: map['policy'],
          code: map['code'],
        );

  /// Get a json [String] representing the [HSMLanguage].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'policy': policy,
        'code': code,
      };
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
  final String defaultValue;

  /// Can be present only if dateTime object is not present. An object of the
  /// form `{"currencyCode": "required string of ISO 4217 currency code", `
  /// `"amount": "required integer of total amount together with cents as a `
  /// `float, multiplied by 1000"}`
  final Currency currency;

  /// Can be present only if currency object is not present. RFC3339
  /// representation of the date and time.
  final DateTime dateTime;

  /// Constructor.
  const HSMLocalizableParameters(
      {this.defaultValue, this.currency, this.dateTime});

  /// Construct a [HSMLocalizableParameters] object from a json [String].
  factory HSMLocalizableParameters.fromJson(String source) =>
      HSMLocalizableParameters.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [HSMLocalizableParameters] object from a [Map].
  factory HSMLocalizableParameters.fromMap(Map<String, dynamic> map) =>
      map == null
          ? null
          : HSMLocalizableParameters(
              defaultValue: map['defaultValue'],
              currency: Currency.fromMap(map['currency']),
              dateTime: parseDate(map['dateTime']));

  /// Get a json object representing the [HSMLocalizableParameters]
  Map<String, dynamic> toJson() =>
      {'defaultValue': defaultValue, 'currency': currency.toJson()};

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'defaultValue': defaultValue,
        'currency': currency?.toMap(),
        'dateTime': dateTime?.toIso8601String(),
      };

  /// Get a list of [HSMLocalizableParameters] objects from a [list] object
  static List<HSMLocalizableParameters> fromList(Object list) => json == null
      ? null
      : List.from(list)
          .map((j) => HSMLocalizableParameters.fromJson(j))
          .toList();
}

/// Class encapsulating image content.
class ImageContent extends Content {
  /// Required for type `image`.
  final Media image;

  /// Constructor.
  const ImageContent(this.image);

  @override
  String toJson() => image.toJson();

  @override
  Map<String, dynamic> toMap() => image.toMap();
}

/// Class encapsulating a location.
class Location {
  /// The latitude coordinates of the location.
  final double latitude;

  /// The longitude coordinates of the location.
  final double longitude;

  /// Constructor.
  const Location({
    this.latitude,
    this.longitude,
  });

  /// Construct an [Location] object from a json [String].
  factory Location.fromJson(String source) =>
      Location.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Location] object from a [Map].
  factory Location.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Location(
          latitude: double.parse(map['latitude'].toString()),
          longitude: double.parse(map['longitude'].toString()),
        );

  /// Get a json [String] representing the [Location].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}

/// Class encapsulating location content.
class LocationContent extends Content {
  /// Required for type `location`.
  final Location location;

  /// Constructor.
  const LocationContent(this.location);

  @override
  String toJson() => location.toJson();

  @override
  Map<String, dynamic> toMap() => location.toMap();
}

/// Class encapsulating a [Media] object.
class Media {
  /// The url of the remote media file.
  final String url;

  /// The caption associated with the media file.
  final String caption;

  /// Constructor.
  const Media({
    this.url,
    this.caption,
  });

  /// Construct an [Media] object from a json [String].
  factory Media.fromJson(String source) =>
      Media.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Media] object from a [Map].
  factory Media.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Media(
          url: map['url'],
          caption: map['caption'],
        );

  /// Get a json [String] representing the [Media].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'url': url,
        'caption': caption,
      };
}

/// Class encapsulating text content.
class TextContent extends Content {
  /// Required for type `text`. The plain-text content of the message.
  final String text;

  /// Constructor.
  const TextContent(this.text);

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {'text': text};
}

/// Class encapsulating video content.
class VideoContent extends Content {
  /// Required for type `video`.
  final Media video;

  /// Constructor.
  const VideoContent(this.video);

  @override
  String toJson() => video.toJson();

  @override
  Map<String, dynamic> toMap() => video.toMap();
}
