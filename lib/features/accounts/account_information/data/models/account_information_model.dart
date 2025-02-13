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
      super.closingAccountName,
      required super.description,
      required super.infoInInvoice,
      required super.barcode,
      required super.files});

  factory AccountInformationModel.fromJson(Map<String, dynamic> json) {
    return AccountInformationModel(
      id: json['id'],
      phone: json['phone'] ?? '',
      mobile: json['mobile'] ?? '',
      fax: json['fax'] ?? '',
      email: json['email'] ?? '',
      contactPersonName: json['contact_person_name'] ?? '',
      address: json['address'] ?? '',
      closingAccountName: json['closing_account'] ?? '',
      description: json['description'] ?? '',
      infoInInvoice: json['info_in_invoice'] ?? '',
      barcode: json['barcode'] ?? '',
      files: json['file'] != null ? List<String>.from(json['file']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      if (phone != null) 'phone': phone,
      if (mobile != null) 'mobile': mobile,
      if (fax != null) 'fax': fax,
      if (email != null) 'email': email,
      if (contactPersonName != null) 'contact_person_name': contactPersonName,
      if (address != null) 'address': address,
      if (description != null) 'description': description,
      if (infoInInvoice != null) 'info_in_invoice': infoInInvoice,
      if (barcode != null) 'barcode': barcode,
      if (files != null) 'file': files
    };
  }
}
