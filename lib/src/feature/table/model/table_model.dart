
enum TableStatus { free, occupied, reserved }

class TableModel {
  final int? id;
  final int tableNumber;
  final String? waiter;
  final DateTime? acceptedAt;
  final TableStatus status;
  final int maxSeats;
  final int seatsOccupied;

  TableModel({
     this.id,
    required this.tableNumber,
    required this.waiter,
    required this.acceptedAt,
    required this.status,
    required this.maxSeats,
    required this.seatsOccupied,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tableNumber': tableNumber,
      'waiter': waiter,
      'acceptedAt': acceptedAt?.millisecondsSinceEpoch,
      'status': status.index,
      'maxSeats': maxSeats,
      'seatsOccupied': seatsOccupied,
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['id']as int?,
      tableNumber: map['tableNumber']as int,
      waiter: map['waiter'],
      acceptedAt: map['acceptedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['acceptedAt']) : null,
      status: TableStatus.values[map['status']],
      maxSeats: map['maxSeats']as int,
      seatsOccupied: map['seatsOccupied']as int,
    );
  }
}
