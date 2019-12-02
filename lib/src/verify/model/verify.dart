import 'dart:convert';

import '../../util.dart';
import '../../voice_messages/model/voice_message.dart';

/// Class encapsulating a [Verify] object.
class Verify {
  /// The telephone number that you want to verify. Required.
  final int recipient;

  /// The sender of the message. This can be a telephone number (including
  /// country code) or an alphanumeric string. In case of an alphanumeric
  /// string, the maximum length is 11 characters.
  final String originator;

  /// A client reference.
  final String reference;

  /// The type of message. See [VerifyType] for allowed values.
  final VerifyType type;

  /// The template of the message body. Needs to contain `%token` for the
  /// verification code to be included.
  final String template;

  /// The datacoding used by the template. See [Datacoding] for allowed values.
  final Datacoding datacoding;

  /// The verification code expiry time in seconds.
  final int timout;

  /// The number of characters in the verification code. Must be between 6 and
  /// 10.
  final int tokenLength;

  /// The voice in which the messages needs to be read to the recipient. See
  /// [Voice] for possible values.
  final Voice voice;

  /// The language in which the message needs to be read to the recipient.
  /// Possible values are: `cy-gb`, `da-dk`, `de-de`, `el-gr`, `en-au`, `en-gb`,
  /// `en-gb-wls`, `en-in`, `en-us`, `es-es`, `es-mx`, `es-us`, `fr-ca`,
  /// `fr-fr`, `id-id`, `is-is`, `it-it`, `ja-jp`, `ko-kr`, `ms-my`, `nb-no`,
  /// `nl-nl`, `pl-pl`, `pt-br`, `pt-pt`, `ro-ro`, `ru-ru`, `sv-se`, `ta-in`,
  /// `th-th`, `tr-tr`, `vi-vn`, `zh-cn`, `zh-hk`.
  final String language;

  /// Constructor.
  Verify({
    this.recipient,
    this.originator = 'Code',
    this.reference,
    this.type,
    this.template = 'Your code is: %token',
    this.datacoding,
    this.timout = 30,
    this.tokenLength = 6,
    this.voice,
    this.language,
  });

  /// Construct a [Verify] object from a json [String].
  factory Verify.fromJson(String source) =>
      Verify.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [Verify] object from a [Map].
  factory Verify.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Verify(
          recipient: map['recipient'],
          originator: map['originator'],
          reference: map['reference'],
          type: VerifyType.values.firstWhere(
              (type) => type.toString() == 'VerifyType.${map['type']}',
              orElse: () => VerifyType.sms),
          template: map['template'],
          datacoding: Datacoding.values.firstWhere(
              (datacoding) =>
                  datacoding.toString() == 'Datacoding.${map['datacoding']}',
              orElse: () => Datacoding.plain),
          timout: parseInt(map['timout']),
          tokenLength: parseInt(map['tokenLength']),
          voice: Voice.values.firstWhere(
              (voice) => voice.toString() == 'Voice.${map['voice']}',
              orElse: () => null),
          language: map['language'],
        );

  /// Get a json [String] representing the [Verify].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'recipient': recipient,
        'originator': originator,
        'reference': reference,
        'type': type?.toString()?.replaceAll('VerifyType.', ''),
        'template': template,
        'datacoding': datacoding?.toString()?.replaceAll('Datacoding.', ''),
        'timout': timout,
        'tokenLength': tokenLength,
        'voice': voice?.toString()?.replaceAll('Voice.', ''),
        'language': language,
      };
}

/// Enumeration of [Verify] types.
enum VerifyType {
  /// The verify message is an sms.
  sms,

  /// The verify message is a flash.
  flash,

  /// The verify message is a tts.
  tts
}

/// Enumeration of datacoding types.
enum Datacoding {
  /// GSM 03.38 characters only.
  plain,

  /// Contains non-GSM 03.38 characters.
  unicode,

  /// Datacoding will be set to unicode or plain depending on the body content.
  auto
}
