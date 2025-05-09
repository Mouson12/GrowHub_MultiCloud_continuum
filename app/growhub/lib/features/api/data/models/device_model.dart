import 'package:growhub/features/api/data/models/fertilizing_device_model.dart';
import 'package:growhub/features/device_dashboard/entities/device_icon.dart';
import 'package:growhub/features/api/data/models/sensor_model.dart';

class DeviceModel {
  final int id;
  final String name;
  final String? location;
  final List<SensorModel> sensors;
  final DeviceIcon icon;
  FertilizingDeviceModel? fertilizingDevice;

  DeviceModel({
    required this.id,
    required this.name,
    this.location,
    required this.sensors,
    required this.icon,
    this.fertilizingDevice,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['device_id'],
      name: json['name'],
      location: json['location'],
      sensors: List<SensorModel>.from(
        json['sensors'].map((x) => SensorModel.fromJson(x)),
      ),
      icon: DeviceIcon.fromIndex(json['icon']),
    );
  }

  DeviceModel copyWith({
    int? id,
    String? name,
    String? location,
    List<SensorModel>? sensors,
    DeviceIcon? icon,
    FertilizingDeviceModel? fertilizingDevice,
  }) {
    return DeviceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
        sensors: sensors ?? this.sensors,
        icon: icon ?? this.icon,
        fertilizingDevice: fertilizingDevice ?? this.fertilizingDevice);
  }
}
