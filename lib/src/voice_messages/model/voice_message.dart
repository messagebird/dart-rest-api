import 'dart:convert';

import 'package:messagebird_dart/src/general/util.dart';
import 'package:messagebird_dart/src/mms/model/recipients.dart';

/// Enumeration of [VoiceMessage] language options.
enum Language {
  /// Welsh.
  // ignore: constant_identifier_names
  cy_gb,

  /// Danish.
  // ignore: constant_identifier_names
  da_dk,

  /// German.
  // ignore: constant_identifier_names
  de_de,

  /// Greek.
  // ignore: constant_identifier_names
  el_gr,

  /// English (Australia).
  // ignore: constant_identifier_names
  en_au,

  /// English (Great Britain).
  // ignore: constant_identifier_names
  en_gb,

  /// Welsh.
  // ignore: constant_identifier_names
  en_gb_wls,

  /// English (India).
  // ignore: constant_identifier_names
  en_in,

  /// English (United States).
  // ignore: constant_identifier_names
  en_us,

  /// Spanish.
  // ignore: constant_identifier_names
  es_es,

  /// Spanish (Mexico).
  // ignore: constant_identifier_names
  es_mx,

  /// Spanish (United States).
  // ignore: constant_identifier_names
  es_us,

  /// Canadian French.
  // ignore: constant_identifier_names
  fr_ca,

  /// French.
  // ignore: constant_identifier_names
  fr_fr,

  /// Indonesian (Indonesia).
  // ignore: constant_identifier_names
  id_id,

  /// Icelandic (Iceland).
  // ignore: constant_identifier_names
  is_is,

  /// Italian (Italy).
  // ignore: constant_identifier_names
  it_it,

  /// Japanese (Japan).
  // ignore: constant_identifier_names
  ja_jp,

  /// Korean (Korea).
  // ignore: constant_identifier_names
  ko_kr,

  /// Malay (Malaysia).
  // ignore: constant_identifier_names
  ms_my,

  /// Norwegian (Norway).
  // ignore: constant_identifier_names
  nb_no,

  /// Dutch (Netherlands).
  // ignore: constant_identifier_names
  nl_nl,

  /// Polish (Poland).
  // ignore: constant_identifier_names
  pl_pl,

  /// Portuguese (Brazil).
  // ignore: constant_identifier_names
  pt_br,

  /// Portuguese (Portugal).
  // ignore: constant_identifier_names
  pt_pt,

  /// Romanian (Romania).
  // ignore: constant_identifier_names
  ro_ro,

  /// Russian (Russia).
  // ignore: constant_identifier_names
  ru_ru,

  /// Swedish (Sweden).
  // ignore: constant_identifier_names
  sv_se,

  /// Tamil (India).
  // ignore: constant_identifier_names
  ta_in,

  /// Thai (Thailand).
  // ignore: constant_identifier_names
  th_th,

  /// Turkish (Turkey).
  // ignore: constant_identifier_names
  tr_tr,

  /// Vietnamese (Vietnam).
  // ignore: constant_identifier_names
  vi_vn,

  /// Chinese (China)
  // ignore: constant_identifier_names
  zh_cn,

  /// Chinese (Hong Kong)
  // ignore: constant_identifier_names
  zh_hk
}

/// Enumeration of [VoiceMessage] ifMachine options. What to do when a machine
/// picks up the phone?
enum MachineOption {
  /// Do not check, just play the message.
  // ignore: constant_identifier_names
  continue_,

  /// If a machine answers, wait until the machine stops talking.
  delay,

  /// Hangup when a machine answers.
  hangup
}

/// Enumeration of [VoiceMessage] voice options.
enum Voice {
  /// Male voice.
  male,

  /// Female voice.
  female
}

/// Class encapsulating a [VoiceMessage].
class VoiceMessage {
  /// A unique random ID which is created on the MessageBird platform and is
  /// returned upon creation of the object.
  final String id;

  /// The URL of the created object.
  final String href;

  /// A client reference.
  final String reference;

  /// The sender of the message. A telephone number (including country code).
  final String originator;

  /// The body of the SMS message. The maxlength is 1000 characters. Check the
  /// [voice body](https://developers.messagebird.com/api/voice-messaging#the-voice-body)
  /// for more options
  final String body;

  /// The language in which the message needs to be read to the recipient. See
  /// [Language] for allowed values.
  final Language language;

  /// The voice in which the messages needs to be read to the recipient. See
  /// [Voice] for allowed values.
  final Voice voice;

  /// The number of times the message needs to be repeated. Maximum is 10 times.
  final int repeat;

  /// What to do when a machine picks up the phone? See [MachineOption] for
  /// allowed values.
  final MachineOption ifMachine;

  /// The time (in milliseconds) to analyze if a machine has picked up the
  /// phone. Used in combination with the delay and hangup values of the
  /// ifMachine attribute.
  final int machineTimeout;

  /// The scheduled date and time of the message in RFC3339 format
  /// (Y-m-d\TH:i:sP)
  final DateTime scheduledDatetime;

  /// The date and time of the creation of the message in RFC3339 format
  /// (Y-m-d\TH:i:sP)
  final DateTime createdDatetime;

  /// Recipient information.
  final Recipients recipients;

  /// Constructor.
  VoiceMessage({
    this.id,
    this.href,
    this.reference,
    this.originator,
    this.body,
    this.language,
    this.voice,
    this.repeat,
    this.ifMachine,
    this.machineTimeout,
    this.scheduledDatetime,
    this.createdDatetime,
    this.recipients,
  });

  /// Construct a [VoiceMessage] object from a json [String].
  factory VoiceMessage.fromJson(String source) =>
      VoiceMessage.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [VoiceMessage] object from a [Map].
  factory VoiceMessage.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : VoiceMessage(
          id: map['id'],
          href: map['href'],
          reference: map['reference'],
          originator: map['originator'],
          body: map['body'],
          language: Language.values.firstWhere(
              (language) =>
                  language.toString() ==
                  'Language.${map['language']}'.replaceAll('-', '_'),
              orElse: () => null),
          voice: Voice.values.firstWhere(
              (voice) => voice.toString() == 'Voice.${map['voice']}',
              orElse: () => null),
          repeat: int.parse(map['repeat'].toString()),
          ifMachine: MachineOption.values.firstWhere(
              (option) =>
                  option.toString() ==
                  'MachineOption.${map['ifMachine']}'.replaceAll('_', ''),
              orElse: () => null),
          machineTimeout: int.parse(map['machineTimeout'].toString()),
          scheduledDatetime: parseDate(map['scheduledDatetime']),
          createdDatetime: parseDate(map['createdDatetime']),
          recipients: Recipients.fromMap(map['recipients']),
        );

  /// Get a json [String] representing the [VoiceMessage].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'href': href,
        'reference': reference,
        'originator': originator,
        'body': body,
        'language': language
            ?.toString()
            ?.replaceAll('Language.', '')
            ?.replaceAll('_', '-'),
        'voice': voice?.toString()?.replaceAll('Voice.', ''),
        'repeat': repeat,
        'ifMachine': ifMachine?.toString()?.replaceAll('MachineOption.', ''),
        'machineTimeout': machineTimeout,
        'scheduledDatetime': scheduledDatetime?.toIso8601String(),
        'createdDatetime': createdDatetime?.toIso8601String(),
        'recipients': recipients.toMap(),
      };
}
