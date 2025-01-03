class ShareholderBenefits {
  /// 株主優待の名称
  final String name;

  /// 届く予測日付
  final DateTime postDay;

  /// 期限が切れる日付
  final DateTime? expiresDay;

  final bool isUsed;

  ShareholderBenefits({
    required this.name,
    required this.postDay,
    required this.expiresDay,
    required this.isUsed,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'postDay': postDay.toIso8601String(),
        'expiresDay': expiresDay?.toIso8601String(),
        'isUsed': isUsed,
      };

  static ShareholderBenefits fromJson(Map<String, dynamic> json) =>
      ShareholderBenefits(
        name: json['name'],
        postDay: DateTime.parse(json['postDay']),
        expiresDay: json['expiresDay'] != null
            ? DateTime.parse(json['expiresDay'])
            : null,
        isUsed: json['isUsed'],
      );
}
