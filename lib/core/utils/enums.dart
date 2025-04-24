// ignore_for_file: constant_identifier_names

enum AccountCategory { asset, liability, equity, revenue, expense }

enum AccountNature { debit, credit }

enum AccountType { main, sub }

enum DirectionType { next, previous, last, first }

enum Status { draft, saved }

enum ProductType {
  commercial,
  finished,
  raw,
  assembly,
  running,
  semi_finished,
  spare_parts,
  production_requirements,
  service
}

enum InvoiceType { sales, purchase }

enum PrinterType { receipt, tax_invoice }

enum ChequeNature { incoming, outgoing }

enum ChequeStatus { received, deposited, bounced, canceled }

getEnumValues<T extends Enum>(List<T> enumValues) {
  return enumValues.map((e) => e.name).toList();
}
