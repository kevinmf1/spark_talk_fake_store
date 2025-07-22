import 'package:flutter/material.dart';

class IncrementDecrementButton extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;

  const IncrementDecrementButton({
    super.key,
    this.initialValue = 1,
    required this.onChanged,
  });

  @override
  State<IncrementDecrementButton> createState() =>
      _IncrementDecrementButtonState();
}

class _IncrementDecrementButtonState extends State<IncrementDecrementButton> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  void _increment() {
    setState(() => _counter++);
    widget.onChanged(_counter);
  }

  void _decrement() {
    if (_counter > 1) {
      setState(() => _counter--);
      widget.onChanged(_counter);
    }
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool enabled,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Icon(
          icon,
          size: 18,
          color: enabled ? Colors.black87 : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: VerticalDivider(
        color: Colors.grey.shade300,
        thickness: 1.5,
        width: 1.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconButton(
            icon: Icons.remove,
            onTap: _decrement,
            enabled: _counter > 1,
          ),
          _buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          _buildDivider(),
          _buildIconButton(icon: Icons.add, onTap: _increment, enabled: true),
        ],
      ),
    );
  }
}
