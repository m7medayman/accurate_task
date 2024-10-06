class LobbyRequest {
  String id;
  String dateTime;
  String deliveryType;
  String typeCode;
  String notes;
  String payeeName;
  LobbyRequest({
    required this.id,
    required this.dateTime,
    required this.deliveryType,
    required this.typeCode,
    required this.notes,
    required this.payeeName,
  });
}
