import 'package:flutter/material.dart';

class FamilyProvider extends InheritedWidget {
  final String familyName;
  const FamilyProvider(
      {super.key, required super.child, required this.familyName});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

class Parents extends StatefulWidget {
  const Parents({super.key});

  @override
  State<Parents> createState() => _ParentsState();
}

class _ParentsState extends State<Parents> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FamilyProvider(
          familyName: 'Smith',
          child: ChildWidget(),
        ),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final familyProvider =
        context.dependOnInheritedWidgetOfExactType<FamilyProvider>();
    final String familyName = familyProvider!.familyName;
    return Text(familyName);
  }
}

class ChildWidget2 extends StatelessWidget {
  const ChildWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    final familyProvider =
        context.dependOnInheritedWidgetOfExactType<FamilyProvider>();
    final String familyName = familyProvider!.familyName;
    return Text(familyName);
  }
}

void main() {
  runApp(const MaterialApp(home: Parents()));
}
