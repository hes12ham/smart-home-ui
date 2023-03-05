import '../core/navigation/navigator.dart';

enum DeviceType { ac, smartTv, cctv,   light }

extension DeviceTypeExtension on DeviceType {
  String get name {
    switch (this) {
      case DeviceType.ac:
        return 'AC';
      case DeviceType.cctv:
        return 'Rain';
      case DeviceType.light:
        return 'Light';
      default:
        return 'Unknown';
    }
  }

  String? get icon {
    switch (this) {
      case DeviceType.ac:
        return 'assets/icons/fan.png';
      case DeviceType.smartTv:
        return 'assets/icons/tv.png';
      case DeviceType.cctv:
        return 'assets/icons/rain2.png';
      case DeviceType.light:
        return 'assets/icons/light.png';
      default:
        return null;
    }
  }

  String get routeName {
    switch (this) {
      case DeviceType.ac:
        return acRoute;
      case DeviceType.cctv:
        return cctvRoute;
      case DeviceType.light:
        return lightRoute;
      default:
        return '/unknown';
    }
  }
}
