import 'dart:async';
import 'package:flutter/material.dart';

class OrderCountdownTimer extends StatefulWidget {
  final int initialSeconds;
  Color? color;

  OrderCountdownTimer({
    super.key,
    this.initialSeconds = 300,
    this.color,
  });

  @override
  State<OrderCountdownTimer> createState() => _OrderCountdownTimerState();
}

class _OrderCountdownTimerState extends State<OrderCountdownTimer> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.initialSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        if (mounted) {
          setState(() => _remainingSeconds--);
        }
      } else {
        _timer?.cancel();
        // implement any action when timer finishes

        debugPrint("Timer Finished!");
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSecs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSecs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${_formatTime(_remainingSeconds)} remaining",
      style: TextStyle(
        color: widget.color ?? Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }
}