enum AccountCategory { asset, liability, equity, revenue, expense }

enum AccountNature { debit, credit }

enum AccountType { main, sub }

enum DirectionType { next, previous, last, first }

getEnumValues<T extends Enum>(List<T> enumValues) {
  return enumValues.map((e) => e.name).toList();
}
