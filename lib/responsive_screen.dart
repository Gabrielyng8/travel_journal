import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Screen'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Small screen
            return Column(
              children: [
                Container(
                  color: Colors.red,
                  height: 100,
                  width: double.infinity,
                  margin: const EdgeInsets.all(8.0),
                ),
                Container(
                  color: Colors.blue,
                  height: 100,
                  width: double.infinity,
                  margin: const EdgeInsets.all(8.0),
                ),
              ],
            );
          } else if (constraints.maxWidth < 1200) {
            // Medium screen
            return Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.red,
                    height: 100,
                    margin: const EdgeInsets.all(8.0),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    height: 100,
                    margin: const EdgeInsets.all(8.0),
                  ),
                ),
              ],
            );
          } else {
            // Large screen
            return GridView.count(
              crossAxisCount: 3,
              children: [
                Container(
                  color: Colors.red,
                  margin: const EdgeInsets.all(8.0),
                ),
                Container(
                  color: Colors.blue,
                  margin: const EdgeInsets.all(8.0),
                ),
                Container(
                  color: Colors.green,
                  margin: const EdgeInsets.all(8.0),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
