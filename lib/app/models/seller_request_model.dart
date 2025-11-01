class SellerRequest {
  int id;
  int userId;
  String shopName;
  String status;
  String submittedAt;

  // New optional fields
  String? name;
  String? email;
  String? phone;
  String? address;
  String? card;

  SellerRequest({
    required this.id,
    required this.userId,
    required this.shopName,
    required this.status,
    required this.submittedAt,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.card,
  });
}
