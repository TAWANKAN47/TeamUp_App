import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RoomCard extends StatelessWidget {
  final Map<String, dynamic> room;
  final bool isOwner;

  /// Callback ต่าง ๆ
  final VoidCallback onJoin;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onViewDetails;

  /// Callback สำหรับแจ้ง WebSocket ตอนดูสมาชิก (ถ้าต้องการใช้)
  final void Function(String roomId)? onViewMembersWebSocket;

  const RoomCard({
    Key? key,
    required this.room,
    required this.isOwner,
    required this.onJoin,
    required this.onEdit,
    required this.onDelete,
    required this.onViewDetails,
    this.onViewMembersWebSocket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // เช็ค location ว่าเป็น object { lat, lng } หรือไม่
    double? lat;
    double? lng;
    final dynamic locationData = room['location'];
    if (locationData != null && locationData is Map<String, dynamic>) {
      lat = locationData['lat']?.toDouble();
      lng = locationData['lng']?.toDouble();
    }

    final bool hasValidLocation = (lat != null && lng != null);

    final bool isFull = room['isFull'] ?? false;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room['sportName'] ?? 'ไม่ระบุชื่อกีฬา',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 8),
                Text('สนาม: ${room['fieldName'] ?? "ไม่ระบุ"}'),
                Text('เวลา: ${room['time'] ?? "ไม่ระบุ"}'),
                Text('ราคา: ${room['pricePerPerson'] ?? 0} บาท/คน'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text('${room['currentParticipants'] ?? 0} / ${room['maxParticipants'] ?? 0}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}