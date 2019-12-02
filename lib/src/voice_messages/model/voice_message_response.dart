import 'dart:convert';

import '../../mms/model/recipients.dart';
import '../../util.dart';
import 'voice_message.dart';

/// Class encapsulating a [VoiceMessageResponse].
class VoiceMessageResponse extends VoiceMessage {
  @override
  final Recipients recipients;

  /// Constructor.
  VoiceMessageResponse({
    id,
    href,
    reference,
    originator,
    body,
    language,
    voice,
    repeat,
    ifMachine,
    machineTimeout,
    scheduledDatetime,
    createdDatetime,
    this.recipients,
  }) : super(
            id: id,
            href: href,
            reference: reference,
            originator: originator,
            body: body,
            language: language,
            voice: voice,
            repeat: repeat,
            ifMachine: ifMachine,
            machineTimeout: machineTimeout,
            scheduledDatetime: scheduledDatetime,
            createdDatetime: createdDatetime);

  /// Construct a [VoiceMessageResponse] object from a json [String].
  factory VoiceMessageResponse.fromJson(String source) =>
      VoiceMessageResponse.fromMap((json.decode(source)['data'] != null)
          ? json.decode(source)['data'][0]
          : json.decode(source));

  /// Construct a [VoiceMessageResponse] object from a [Map].
  factory VoiceMessageResponse.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : VoiceMessageResponse(
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
          repeat: parseInt(map['repeat']),
          ifMachine: MachineOption.values.firstWhere(
              (option) =>
                  option.toString() ==
                  'MachineOption.${map['ifMachine']}'.replaceAll('_', ''),
              orElse: () => null),
          machineTimeout: parseInt(map['machineTimeout']),
          scheduledDatetime: parseDate(map['scheduledDatetime']),
          createdDatetime: parseDate(map['createdDatetime']),
          recipients: Recipients.fromMap(map['recipients']),
        );
}
