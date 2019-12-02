import 'dart:io';

import 'package:messagebird/messagebird.dart';
import 'package:test/test.dart';

void main() {
  Email email;
  HSMContent hsmContent;
  LocationContent locationContent;
  TextContent textContent;
  ImageContent imageContent;
  VideoContent videoContent;
  AudioContent audioContent;
  FileContent fileContent;

  group('EmailContent', () {
    setUp(() {
      email = Content.fromJson(MessageType.email,
          File('test_resources/content/email_content.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(email.subject, equals('Hello from Drillster'));
      expect(email.to[0].name, equals('Jane Doe'));
      expect(email.to[0].email, equals('jane@drillster.com'));
      expect(email.from.name, equals('Luc'));
      expect(email.from.email, equals('luc@drillster.com'));
      expect(email.content.html, isNotNull);
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = email.toMap();

      expect(serialized['subject'], equals('Hello from Drillster'));
      expect(serialized['to'][0]['name'], equals('Jane Doe'));
      expect(serialized['from']['name'], equals('Luc'));
      expect(serialized['content']['html'], isNotNull);
    });
  });

  group('HSMContent', () {
    setUp(() {
      hsmContent = Content.fromJson(MessageType.hsm,
          File('test_resources/content/hsm_content.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(hsmContent.language.code, equals('en'));
      expect(hsmContent.language.policy, equals('deterministic'));
      expect(
          hsmContent.namespace, equals('5ba2d0b7_f2c6_433b_a66e_57b009ceb6ff'));
      expect(hsmContent.templateName, equals('support'));
      expect(hsmContent.parameters.length, equals(2));
      expect(hsmContent.parameters[0].defaultValue, 'Bob');
      expect(hsmContent.parameters[1].defaultValue, 'tomorrow!');
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = hsmContent.toMap();

      expect(serialized['language']['code'], equals('en'));
      expect(serialized['language']['policy'], equals('deterministic'));
      expect(serialized['namespace'],
          equals('5ba2d0b7_f2c6_433b_a66e_57b009ceb6ff'));
      expect(serialized['templateName'], equals('support'));
      expect(serialized['params'][0]['default'], equals('Bob'));
      expect(serialized['params'][1]['default'], equals('tomorrow!'));
    });
  });

  group('LocationContent', () {
    setUp(() {
      locationContent = Content.fromJson(
          MessageType.location,
          File('test_resources/content/location_content.json')
              .readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(locationContent.location.latitude, equals(52.090736));
      expect(locationContent.location.longitude, equals(5.121420));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = locationContent.toMap();
      expect(serialized['location']['latitude'], equals(52.090736));
      expect(serialized['location']['longitude'], equals(5.121420));
    });
  });

  group('TextContent', () {
    setUp(() {
      textContent = Content.fromJson(MessageType.text,
          File('test_resources/content/text_content.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(textContent.text, equals('Hello world!'));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serialized = textContent.toMap();
      expect(serialized['text'], equals('Hello world!'));
    });
  });

  group('MediaContent', () {
    setUp(() {
      imageContent = Content.fromJson(MessageType.image,
          File('test_resources/content/image_content.json').readAsStringSync());
      audioContent = Content.fromJson(MessageType.audio,
          File('test_resources/content/audio_content.json').readAsStringSync());
      videoContent = Content.fromJson(MessageType.video,
          File('test_resources/content/video_content.json').readAsStringSync());
      fileContent = Content.fromJson(MessageType.file,
          File('test_resources/content/file_content.json').readAsStringSync());
    });

    test('should deserialize from json', () {
      expect(imageContent.image.url, equals('https://test.com/test.jpg'));
      expect(imageContent.image.caption, equals('Lorem ipsum'));

      expect(audioContent.audio.url, equals('https://test.com/test.jpg'));
      expect(audioContent.audio.caption, equals('Lorem ipsum'));

      expect(videoContent.video.url, equals('https://test.com/test.jpg'));
      expect(videoContent.video.caption, 'Lorem ipsum');

      expect(fileContent.file.url, equals('https://test.com/test.jpg'));
      expect(fileContent.file.caption, equals(null));
    });

    test('should serialize to json', () {
      final Map<String, dynamic> serializedImage = imageContent.toMap();
      final Map<String, dynamic> serializedAudio = audioContent.toMap();
      final Map<String, dynamic> serializedVideo = videoContent.toMap();
      final Map<String, dynamic> serializedFile = fileContent.toMap();

      expect(
          serializedImage['image']['url'], equals('https://test.com/test.jpg'));
      expect(serializedImage['image']['caption'], equals('Lorem ipsum'));

      expect(
          serializedAudio['audio']['url'], equals('https://test.com/test.jpg'));
      expect(serializedAudio['audio']['caption'], equals('Lorem ipsum'));

      expect(
          serializedVideo['video']['url'], equals('https://test.com/test.jpg'));
      expect(serializedVideo['video']['caption'], equals('Lorem ipsum'));

      expect(
          serializedFile['file']['url'], equals('https://test.com/test.jpg'));
      expect(serializedFile['file']['caption'], isNull);
    });
  });
}
