enum EnumBusServiceStatus {
  on(label: "ON"),
  off(label: "OFF"),
  ;

  final String label;
  const EnumBusServiceStatus({required this.label});
}
