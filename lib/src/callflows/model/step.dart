import 'dart:convert';

/// Class encapsulating a [Step] object.
class Step {
  /// The unique (within the call flow) identifier of the step.
  final String id;

  /// The name of the VoIP action. See [StepAction] for allowed values.
  final StepAction action;

  /// Contains zero or more key-value pairs, where the key is the identifier of
  /// the option and value is the option value. See [StepOption] for allowed
  /// values.
  final Map<StepOption, Object> options;

  /// Constructor.
  const Step({
    this.id,
    this.action,
    this.options,
  });

  /// Construct a [Step] object from a json [String].
  factory Step.fromJson(String source) => Step.fromMap(
      json.decode(source)['data'][0] ?? json.decode(source)['data']);

  /// Construct a [Step] object from a [Map].
  factory Step.fromMap(Map<String, dynamic> map) => map == null
      ? null
      : Step(
          id: map['id'].toString(),
          action: StepAction.values.firstWhere(
              (action) => action.toString() == 'StepAction.${map['action']}',
              orElse: () => null),
          options: map['options'] == null
              ? null
              : Map.from(map['options']).map<StepOption, Object>((key, value) =>
                  MapEntry(
                      StepOption.values.firstWhere(
                          (option) => option.toString() == 'StepOption.$key'),
                      value)));

  /// Get a json [String] representing the [Step].
  String toJson() => json.encode(toMap());

  /// Convert this object to a [Map].
  Map<String, dynamic> toMap() => {
        'id': id,
        'action': action?.toString()?.replaceAll('StepAction.', ''),
        'options': options?.map<String, String>((option, value) =>
            MapEntry(option.toString().replaceAll('StepOption.', ''), value))
      };
}

/// Enumeration of [Step] actions.
enum StepAction {
  /// Transfer the call.
  transfer,

  /// Pronounce text.
  say,

  /// Play media.
  play,

  /// Pause media.
  pause,

  /// Record the call.
  record,

  /// Fetch the call flow.
  fetchCallFlow,

  /// Send keys.
  sendKeys,

  /// Stop the call.
  hangup,
}

/// Enumeration of [Step] options.
enum StepOption {
  /// The destination (E.164 formatted number, SIP URI or Client URI) to
  /// transfer a call to. E.g. `31612345678`, `sip:foobar@example.com`, or
  /// `client:name_of_client`. The Client URI is in early access at this moment
  /// as part of our Client SDK. Required when `step.action` is `transfer`.
  destination,

  /// The text to pronounce. Required when `step.action` is `say`.
  payload,

  /// The language of the text that is to be pronounced. Required when
  /// `step.action` is `say`. Allowed values: `bg-BG`, `cs-CZ`, `cy-GB`,
  /// `da-DK`, `de-DE`, `el-GR`, `en-AU`, `en-GB-WLS`, `en-GB`, `en-IN`,
  /// `en-US`, `es-ES`, `es-MX`, `es-US`, `fr-CA`, `fr-FR`, `hr-HR`, `id-ID`,
  /// `is-IS`, `it-IT`, `ja-JP`, `ko-KR`, `ms-MY`, `nb-NO`, `nl-NL`, `pl-PL`,
  /// `pt-BR`, `pt-PT`, `ro-RO`, `ru-RU`, `sk-SK`, `sv-SE`, `ta-IN`, `th-TH`,
  /// `tr-TR`, `vi-VN`, `zh-CN`, `zh-HK`.
  language,

  /// The preferred voice to use for pronouncing text. Required when
  /// `step.action` is `say`. Allowed values: `male`, `female`. This preference
  /// is ignored if the desired voice is not available for the selected
  /// language.
  voice,

  /// The amount of times to repeat the payload. Optional when `step.action` is
  /// `say`. Allowed values: Between 1 and 10.
  repeat,

  /// The URL(s) of the media file(s) to play. Required when `step.action` is
  /// `play`. The URL should end in either `.wav` or `.mp3`, note this can also
  /// be part of the last query parameter, so
  /// `http://www.example.com/test.mp3?foo=bar&format=.mp3` is a valid format.
  /// Note that in the case of multiple media files in this `media` attribute,
  /// all need to be ending with `.wav`. Wave file format should be 8 kHz,
  /// 16 bit.
  media,

  /// The length of the pause in seconds. Required when `step.action`
  /// is `pause`.
  length,

  /// Maximum length of a recording in seconds, when this time limit is reached,
  /// the recording will stop. It is used when `step.action` is `record` and it
  /// is optional with the default value being 0 which means no limit.
  maxLength,

  /// Seconds of silence allowed before a recording is stopped. It is used when
  /// `step.action` is `record` and it is optional. If you omit this parameter,
  /// silence detection is disabled.
  timeout,

  /// Key DTMF input to terminate recording. Values allowed are any, #, *, none.
  /// It is used when `step.action` is `record` and it is optional with the
  /// default value being `none`.
  finishOnKey,

  /// If you want to have a transcription of a recording, after the recording
  /// has finished. It is used when `step.action` is `record` and it is optional
  /// with the default value being false.
  transcribe,

  /// The language of the recording that is to be transcribed. Required when
  /// `transcribe` is `true`. Allowed values: `de-DE`, `en-AU`, `en-UK`,
  /// `en-US`, `es-ES`, `es-LA`, `fr-FR`, `it-IT`, `nl-NL`, `pt-BR`.
  transcribeLanguage,

  /// Optional when `step.action` is `transfer`. Available options are `in`,
  /// `out` and `both`. It can be used to record a call for a transfer action.
  /// Option `in` is being used to record the voice of the destination and `out`
  /// for the source. You can use `both` to record both source and destination
  /// individually.
  record,

  /// The URL to fetch a call flow from. Required when `step.action` is
  /// `fetchCallFlow`. See: [Dynamic call flows](https://developers.messagebird.com/api/voice-calling#dynamic-call-flows).
  url,

  /// Optional when `step.action` is `say`. What to do when a machine picks up
  /// the phone? Possible values are:
  ///
  /// * `continue` do not check, just play the message
  /// * `delay` if a machine answers, wait until the machine stops talking
  /// * `hangup` hangup when a machine answers
  ///
  /// Default is: `delay`.
  ifMachine,

  /// Optional when `step.action` is `say`. The time (in milliseconds) to
  /// analyze if a machine has picked up the phone. Used in combination with
  /// the `delay` and `hangup` values of the `ifMachine` attribute.
  /// Minimum: 400, maximum: 10000.
  ///
  /// Default is: 7000.
  machineTimeout,

  /// Optional when `step.action` is `record`. The `onFinish` is a URL from
  /// which a new call flow is fetched. The request is a `POST` request and
  /// contains details of the [recording](https://developers.messagebird.com/api/voice-calling#recordings). See: [Dynamic call flows](https://developers.messagebird.com/api/voice-calling#dynamic-call-flows).
  onFinish,

  /// Optional when `step.action` is `transfer`. Mask instructs MessageBird to
  /// use the proxy number (the called VMN for example) instead of the original
  /// caller ID.
  ///
  /// Default is: false.
  mask,

  /// API doc missing.
  token,
}
