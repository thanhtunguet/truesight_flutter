import 'package:flutter/material.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

Color _hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

class EnumStatusBadge extends StatefulWidget {
  final EnumModel status;

  const EnumStatusBadge({
    super.key,
    required this.status,
  });

  @override
  State<EnumStatusBadge> createState() => _EnumStatusBadgeState();
}

class _EnumStatusBadgeState extends State<EnumStatusBadge> {
  late Color color;

  @override
  void initState() {
    super.initState();
    color = _hexToColor(widget.status.color.rawValue ?? '#FDDC69');
  }

  @override
  Widget build(BuildContext context) {
    return TextStatusBadge(
      status: widget.status.name.value,
      color: color,
    );
  }
}
