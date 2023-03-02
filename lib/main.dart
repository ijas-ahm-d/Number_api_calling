import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rest_api/apis.dart';
import 'package:rest_api/result.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
 const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final numberInputController = TextEditingController();

  String resultText = '';
  String resultType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        38,
        86,
        182,
      ),
      appBar: AppBar( elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          "Number's API",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Type a number and press Get Result",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: TextFormField(
                controller: numberInputController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}'),
                  ),
                ],
                decoration:  InputDecoration(
                  fillColor: Colors.blue[100],
                  filled: true,
                  
                  hintText: 'Please input a number',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                final num = numberInputController.text;
                final result = await getNumberFact(number: num);
                resultText = result.text ?? "No Value Found";
                resultType = result.type ?? 'No Data found';
               
                gotoDetails(resultText, num, resultType);
              },
              child: const Text(
                'Get Result',
              ),
            ),
           
          ],
        ),
      ),
    );
  }

  void gotoDetails(text, num1, type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ResultScreen(text: text, num: num1, type: type);
        },
      ),
    );
  }
}
