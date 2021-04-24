class Transaction {
  String id;
  String title;
  double amount;
  DateTime createAt;
  DateTime updatedAt;

  Transaction({
    this.id,
    this.title,
    this.amount,
    this.createAt,
    this.updatedAt,
  });
}
