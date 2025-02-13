import 'package:equatable/equatable.dart';

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
