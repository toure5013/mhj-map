class NavigatrFormat {
  static String duration(int seconds) {
    final totalMinutes = (seconds / 60).round();

    if (totalMinutes < 60) {
      return '$totalMinutes min${totalMinutes != 1 ? 's' : ''}';
    }

    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (minutes == 0) {
      return '$hours hr${hours != 1 ? 's' : ''}';
    }

    return '$hours hr${hours != 1 ? 's' : ''} $minutes min${minutes != 1 ? 's' : ''}';
  }

  static String distance(int meters) {
    if (meters < 1000) {
      return '$meters m';
    }

    final km = meters / 1000.0;
    return '${km.toStringAsFixed(1)} km';
  }
}
