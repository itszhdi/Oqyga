import 'package:oqyga_frontend/features/filters/domain/entities/age_restriction.dart';

class AgeRestrictionModel extends AgeRestriction {
  const AgeRestrictionModel({required super.ageId, required super.ageCategory});

  factory AgeRestrictionModel.fromJson(Map<String, dynamic> json) {
    return AgeRestrictionModel(
      ageId: json['ageId'] as int,
      ageCategory: json['ageCategory'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ageId': ageId, 'ageCategory': ageCategory};
  }
}
