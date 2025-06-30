import 'dart:math';

import 'package:flutter/material.dart';

enum Status {
  ok(Colors.green, 0, "OK"),
  warning(Colors.amber, 1, "Warning"),
  error(Colors.red, 2, "Error");

  final Color color;
  final int priority;
  final String name;

  const Status(this.color, this.priority, this.name);

  @override
  String toString() {
    return name;
  }

  static Status? fromPriority(int val) {
    if (val == ok.priority) return ok;
    if (val == warning.priority) return warning;
    if (val == error.priority) return error;

    return null;
  }

  static Status maxPriority(Status a, Status b) {
    return Status.fromPriority(max(a.priority, b.priority))!;
  }
}
