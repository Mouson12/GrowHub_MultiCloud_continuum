import 'package:growhub/features/api/core/ip_path.dart';

class ApiClientPath {
  static Uri userInfo() {
    return Uri.parse("${IpPath.ip}/api/user/info");
  }

  static Uri appConfiguration() {
    return Uri.parse("${IpPath.ip}/api/configuration");
  }

  static Uri sensorReadings(int deviceId) {
    return Uri.parse("${IpPath.ip}/api/sensor-readings/$deviceId");
  }

  static Uri dosageHistory(int deviceId) {
    return Uri.parse("${IpPath.ip}/api/dosage-history/$deviceId");
  }

  static Uri devices(int deviceId) {
    return Uri.parse("${IpPath.ip}/api/devices/$deviceId");
  }

  static Uri sensorValues(int sensorId) {
    return Uri.parse("${IpPath.ip}/api/sensor-values/$sensorId");
  }

  static Uri alerts() {
    return Uri.parse("${IpPath.ip}/api/alerts");
  }

  static Uri resolveAlert(int alertId) {
    return Uri.parse("${IpPath.ip}/api/alerts/$alertId/resolve");
  }

  static Uri deleteAlert(int alertId) {
    return Uri.parse("${IpPath.ip}/api/alerts/$alertId");
  }

  static Uri userDevicesSsid() {
    return Uri.parse("${IpPath.ip}/api/user-devices/ssid");
  }

  static Uri fertilizingDeviceByDeviceId(int deviceId) {
    return Uri.parse("${IpPath.ip}/api/fertilizing-devices/$deviceId");
  }
}
