import 'package:equatable/equatable.dart';

class AccountInformationEntity extends Equatable {
  final int id;
  final String phone;
  final String mobile;
  final String fax;
  final String email;
  final String contactPersonName;
  final String address;
  final String description;
  final String infoInInvoice;
  final String barcode;
  final String file;

  const AccountInformationEntity(
      {required this.id,
      required this.phone,
      required this.mobile,
      required this.fax,
      required this.email,
      required this.contactPersonName,
      required this.address,
      required this.description,
      required this.infoInInvoice,
      required this.barcode,
      required this.file});

  @override
  List<Object?> get props => [
        id,
        phone,
        mobile,
        fax,
        email,
        contactPersonName,
        address,
        description,
        infoInInvoice,
        barcode,
        file
      ];
}
