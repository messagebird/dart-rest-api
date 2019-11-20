enum Content {
  TextContent,
  ImageContent,
  AudioContent,
  FileContent,
  LocationContent,
  HSMContent
}

abstract class TextContent {
  String text;
}

abstract class ImageContent {
  File image;
}

abstract class AudioContent {
  File video;
}

abstract class FileContent {
  File file;
}

abstract class File {
  String url;
}

abstract class LocationContent {
  Location location;
}

class Location {
  double latitude;
  double longitude;

  Location(this.latitude, this.longitude);
}

abstract class HSMContent {
  String namespace;

  String templateName;
  HSMLanguage language;
  List<HSMLocalizableParameters> parameters;
}

abstract class HSMLanguage {
  String policy;
  String code;
}

abstract class HSMLocalizableParameters {
  String defaultValue;
  Currency currency;
  DateTime dateTime;
}

class Currency {
  String currencyCode;
  double amount;

  Currency(this.currencyCode, this.amount);
}
