import 'package:ngu_app/features/accounts/account_information/domain/entities/account_information_entity.dart';

class AccountInformationModel extends AccountInformationEntity {
  const AccountInformationModel(
      {required super.id,
      required super.phone,
      required super.mobile,
      required super.fax,
      required super.email,
      required super.contactPersonName,
      required super.address,
      required super.description,
      required super.infoInInvoice,
      required super.barcode,
      required super.file});

  factory AccountInformationModel.fromJson(Map<String, dynamic> json) {
    return AccountInformationModel(
        id: json['id'],
        phone: json['phone'] ?? '',
        mobile: json['mobile'] ?? '',
        fax: json['fax'] ?? '',
        email: json['email'] ?? '',
        contactPersonName: json['contact_person_name'] ?? '',
        address: json['address'] ?? '',
        description: json['description'] ?? '',
        infoInInvoice: json['info_in_invoice'] ?? '',
        barcode: json['barcode'] ?? '',
        file: json['file'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'mobile': mobile,
      'fax': fax,
      'email': email,
      'contact_person_name': contactPersonName,
      'address': address,
      'description': description,
      'info_in_invoice': infoInInvoice,
      'barcode': barcode,
      'file': file
    };
  }
}
