enum AccountCategory { asset, liability, equity, revenue, expense }

enum AccountNature { debit, credit }

enum AccountType { main, sub }

getEnumValues<T extends Enum>(List<T> enumValues) {
  return enumValues.map((e) => e.name).toList();
}
