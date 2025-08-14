import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:car_app_2/CarInfoProvider.dart';
import 'package:car_app_2/basicinfowidget.dart';
import 'package:car_app_2/car_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();

  runApp(
    ChangeNotifierProvider(
      create: (_) => CarInfoProvider(),
      child: const MainApp(),
    ),
  );
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      _cameras[0],
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
Future<http.StreamedResponse> createAlbum(XFile image) async {
  var uri = Uri.parse('http://10.148.69.119:8000/car/api/');
  var request = http.MultipartRequest('POST', uri);

  request.files.add(
    await http.MultipartFile.fromPath(
      'image', 
      image.path,
    ),
  );

  return await request.send();
}

Future<void> _takePicture() async {
  try {
    await _initializeControllerFuture;
    final image = await _controller.takePicture();
    var streamedResponse = await createAlbum(image);
    var response = await http.Response.fromStream(streamedResponse);
    if( response.statusCode == 200)
    {
      final jsonData = jsonDecode(response.body);
      final carInfo = CarInfo.fromJson(jsonData);
      Provider.of<CarInfoProvider>(context, listen: false).setCarInfo(carInfo);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const BasicInfoWidget(
        ))
      );
    }
    else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not find the numberplate')),
        );
    }

  } catch (e) {
    print('Error taking picture: $e');
  }
}


    @override
    Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
            return Column(
                children: [
                const SizedBox(height: 50),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                    'Take a picture of a number plate',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    ),
                ),
                Expanded(
                    child: CameraPreview(_controller),
                ),
                Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ElevatedButton.icon(
                    onPressed: _takePicture,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Picture'),
                    ),
                ),
                ],
            );
            } else {
            return const Center(child: CircularProgressIndicator());
            }
        },
        ),
    );
    }

}
