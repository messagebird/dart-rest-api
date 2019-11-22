/// Class encapsulating an [Hlr] (Home Location Registering) object.
class Hlr {
  /// A unique random ID which is created on the MessageBird platform and is
  /// returned upon creation of the object.
  String id;

  /// The URL of the created object.
  String href;

  /// The telephone number.
  int msisdn;

  /// The [MCCMNC](https://en.wikipedia.org/wiki/Mobile_country_code) code of
  /// the network provider.
  int network;

  /// A client reference.
  String reference;

  /// Extra HLR information. See [HlrDetails] for extra information.
  HlrDetails details;

  /// The status of the msisdns. See [HlrStatus] for allowed values.
  HlrStatus status;

  /// The date and time of the creation of the message in RFC3339 format
  /// (Y-m-d\TH:i:sP)
  DateTime createdDatetime;

  /// The datum time of the last status in RFC3339 format (Y-m-d\TH:i:sP)
  DateTime statusDatetime;

  /// Constructor.
  Hlr(
      {this.id,
      this.href,
      this.msisdn,
      this.network,
      this.reference,
      this.details,
      this.status,
      this.createdDatetime,
      this.statusDatetime});

  /// Construct an [Hlr] object from a [json] object.
  factory Hlr.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : Hlr(
          id: json['id'].toString(),
          href: json['href'].toString(),
          msisdn: int.parse(json['msisdn']),
          network: int.parse(json['network']),
          reference: json['reference'].toString(),
          details: HlrDetails.fromJson(json['details']),
          status: HlrStatus.values.firstWhere(
              (status) => status.toString() == 'HlrStatus.${json['status']}',
              orElse: () => null),
          createdDatetime: DateTime.parse(json['createdDatetime'].toString()),
          statusDatetime: DateTime.parse(json['statusDatetime'].toString()));
}

/// Class encapsulating [HlrDetails].
///
/// Note that the attributes can change over time and some of them can be null
/// because not all information is available for all countries and provider.
class HlrDetails {
  /// Extended status information
  String status_desc;

  /// [IMSI (International Mobile Subscriber Identity)](https://en.wikipedia.org/wiki/International_mobile_subscriber_identity)
  /// of mobile number.
  String ismi;

  /// Country ISO code of location of MSISDN.
  String country_iso;

  /// Country name of location of MSISDN.
  String country_name;

  /// [MSC (Mobile Switching Center)](https://en.wikipedia.org/wiki/Network_switching_subsystem#Mobile_switching_center_.28MSC.29)
  /// of MSISDN
  String location_msc;

  /// Country ISO of MSC ([lowercase ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2))
  String location_iso;

  /// Is 1 if the phone number is ported or 0 when the phone number is not
  /// ported or ported status is unknown
  bool ported;

  /// Is 1 if the phone number is roaming or 0 when the phone number is not
  /// roaming or roaming status is unknown
  bool roaming;

  /// Constructor.
  HlrDetails(
      {this.status_desc,
      this.ismi,
      this.country_iso,
      this.country_name,
      this.location_msc,
      this.location_iso,
      this.ported,
      this.roaming});

  /// Construct an [HlrDetails] object from a [json] object.
  factory HlrDetails.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : HlrDetails(
          status_desc: json['status_desc'].toString(),
          ismi: json['ismi'].toString(),
          country_iso: json['country_iso'].toString(),
          country_name: json['country_name'].toString(),
          location_msc: json['location_msc'].toString(),
          location_iso: json['location_iso'].toString(),
          ported:
              json['ported'] == null ? null : int.parse(json['ported']) == 1,
          roaming:
              json['roaming'] == null ? null : int.parse(json['roaming']) == 1);
}

/// Enumeration of [Hlr] statusses
enum HlrStatus {
  /// [Hlr] is sent.
  sent,

  /// [Hlr] is absent.
  absent,

  /// [Hlr] is active.
  active,

  /// [Hlr] is unknown.
  unknown,

  /// [Hlr] has failed
  failed
}
