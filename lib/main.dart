import 'dart:async'; 
import 'package:flutter/material.dart'; 
import 'package:sensors_plus/sensors_plus.dart'; 

void main() { 
runApp(const MyApp()); 
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
@override 
Widget build(BuildContext context) { 
	return MaterialApp( 
	theme: ThemeData( 
		primarySwatch: Colors.green, // Set the app's primary theme color 
	), 
	debugShowCheckedModeBanner: false, 
	home: const AccelerometerExample(), 
	); 
} 
} 

class AccelerometerExample extends StatefulWidget { 
const AccelerometerExample({super.key}); 

@override 
State<AccelerometerExample> createState() => _AccelerometerExampleState(); 
} 

class _AccelerometerExampleState extends State<AccelerometerExample> { 
// List to store accelerometer data 
List<AccelerometerEvent> _accelerometerValues = []; 

// StreamSubscription for accelerometer events 
late StreamSubscription<AccelerometerEvent> _accelerometerSubscription; 

@override 
void initState() { 
	super.initState(); 

	// Subscribe to accelerometer events 
	_accelerometerSubscription = accelerometerEventStream().listen((event) { 
	setState(() { 
		// Update the _accelerometerValues list with the latest event 
		_accelerometerValues = [event]; 
	}); 
	}); 
} 

@override 
void dispose() { 
	// Cancel the accelerometer event subscription to prevent memory leaks 
	_accelerometerSubscription.cancel(); 
	super.dispose(); 
} 

@override 
Widget build(BuildContext context) { 
	return Scaffold( 
	appBar: AppBar( 
		title: const Text('Accelerometer Example'), 
	), 
	body: Center( 
		child: Column( 
		mainAxisAlignment: MainAxisAlignment.center, 
		children: <Widget>[ 
			const Text( 
			'Accelerometer Data:', 
			style: TextStyle(fontSize: 20), 
			), 
			const SizedBox(height: 10), 
			if (_accelerometerValues[0].z < 8) 
			Text( 
				'X: ${_accelerometerValues[0].x.toStringAsFixed(2)}, '
				'Y: ${_accelerometerValues[0].y.toStringAsFixed(2)}, '
				'Z: ${_accelerometerValues[0].z.toStringAsFixed(2)}', 
				style: const TextStyle(fontSize: 16), 
			) 
			else
			const Text('No data available', style: TextStyle(fontSize: 16)), 
		], 
		), 
	), 
	); 
} 
} 
