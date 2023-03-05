import '../../../../utils/enums.dart';

class Device {
  String? name;
  DeviceType type;
  bool active;
  String room;

  Device(
      {this.name,
      required this.type,
      required this.active,
      required this.room});
}

List<Device> devices = [
  Device(
    name: 'Fan',
    type: DeviceType.ac,
    active: true,
    room: 'Living Room',
  ),
  Device(
    name: 'Rain',
    type: DeviceType.cctv,
    active: true,
    room: '',
  ),
  Device(
    name: 'Light',
    type: DeviceType.light,
    active: true,
    room: 'Living Room',
  ),
];
