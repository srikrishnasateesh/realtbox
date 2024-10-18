import 'package:flutter/material.dart';

class ProgressTracker extends StatelessWidget {
  final double pickedProgress = 0.5;  // 50% progress
  final double receivedProgress = 1.0;  // 100% progress
  final double washedProgress = 0.5;  // 50% progress

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                _buildVerticalProgressBar(pickedProgress),
                _buildProgressStep("Picked", pickedProgress),
                _buildHorizontalProgressBar(pickedProgress),
                _buildProgressStep("Received", receivedProgress),
                _buildHorizontalProgressBar(receivedProgress),
                _buildProgressStep("Washed", washedProgress),
              ],
            ),
            _buildVerticalProgressBar(washedProgress),
            _buildProgressStep("Delivered", 1.0),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep(String label, double progress) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: progress == 1.0 ? Colors.green : Colors.grey,
          child: Icon(
            progress == 1.0 ? Icons.check : Icons.hourglass_empty,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildHorizontalProgressBar(double progress) {
    return Expanded(
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }

  Widget _buildVerticalProgressBar(double progress) {
    return Column(
      children: [
        Container(
          width: 2,
          height: 50,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProgressTracker(),
  ));
}
