// To parse this JSON data, do
//
//     final currency = currencyFromJson(jsonString);

import 'dart:convert';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

class Currency {
  Currency({
    required this.result,
    required this.provider,
    required this.documentation,
    required this.termsOfUse,
    required this.timeLastUpdateUnix,
    required this.timeLastUpdateUtc,
    required this.timeNextUpdateUnix,
    required this.timeNextUpdateUtc,
    required this.timeEolUnix,
    required this.baseCode,
    required this.rates,
  });

  String result;
  String provider;
  String documentation;
  String termsOfUse;
  int timeLastUpdateUnix;
  String timeLastUpdateUtc;
  int timeNextUpdateUnix;
  String timeNextUpdateUtc;
  int timeEolUnix;
  String baseCode;
  Map<String, double> rates;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        result: json["result"],
        provider: json["provider"],
        documentation: json["documentation"],
        termsOfUse: json["terms_of_use"],
        timeLastUpdateUnix: json["time_last_update_unix"],
        timeLastUpdateUtc: json["time_last_update_utc"],
        timeNextUpdateUnix: json["time_next_update_unix"],
        timeNextUpdateUtc: json["time_next_update_utc"],
        timeEolUnix: json["time_eol_unix"],
        baseCode: json["base_code"],
        rates: Map.from(json["rates"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "provider": provider,
        "documentation": documentation,
        "terms_of_use": termsOfUse,
        "time_last_update_unix": timeLastUpdateUnix,
        "time_last_update_utc": timeLastUpdateUtc,
        "time_next_update_unix": timeNextUpdateUnix,
        "time_next_update_utc": timeNextUpdateUtc,
        "time_eol_unix": timeEolUnix,
        "base_code": baseCode,
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
