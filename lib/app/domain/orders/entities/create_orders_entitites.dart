class CreateOrdersEntitites {
  final List<int>? cartIds;
  final String? methodPembayaran;
  final int? ongkir;
  final int? addressId;

  CreateOrdersEntitites({
    this.cartIds,
    this.methodPembayaran,
    this.ongkir,
    this.addressId,
  });
  Map<String, dynamic> toJson() => {
        "cart_ids":
            cartIds == null ? [] : List<dynamic>.from(cartIds!.map((x) => x)),
        "method_pembayaran": methodPembayaran,
        "ongkir": ongkir,
        "address_id": addressId,
      };
}
