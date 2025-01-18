import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/accounts/account_information/data/models/account_information_model.dart';

class AccountInformationEntity extends Equatable {
  final int? id;
  final String? phone;
  final String? mobile;
  final String? fax;
  final String? email;
  final String? contactPersonName;
  final String? address;
  final String? closingAccountName;
  final String? description;
  final String? infoInInvoice;
  final String? barcode;
  final List<String>? files;

  const AccountInformationEntity(
      {this.id,
      this.phone,
      this.mobile,
      this.fax,
      this.email,
      this.contactPersonName,
      this.address,
      this.closingAccountName,
      this.description,
      this.infoInInvoice,
      this.barcode,
      this.files});

  AccountInformationModel toModel() {
    return AccountInformationModel(
        id: id,
        phone: phone,
        mobile: mobile,
        fax: fax,
        email: email,
        contactPersonName: contactPersonName,
        address: address,
        description: description,
        infoInInvoice: infoInInvoice,
        barcode: barcode,
        files: files);
  }

  @override
  List<Object?> get props => [
        id,
        phone,
        mobile,
        fax,
        email,
        contactPersonName,
        address,
        closingAccountName,
        description,
        infoInInvoice,
        barcode,
        files
      ];
}
