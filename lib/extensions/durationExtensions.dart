extension DurationExtensions on Duration {
  String toTimeString() {
    String twoDigitMinutes = this.inMinutes.remainder(60).toTwoDigits();
    String twoDigitSeconds = this.inSeconds.remainder(60).toTwoDigits();
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

extension IntExtensions on num {
  String toTwoDigits() {
    if (this >= 10) return "$this";
      return "0$this";
  }
}