import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oreo_app/components/custom_button.dart';
import 'package:oreo_app/view/details_page.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

double _value = 1.0;
String inString = _value.toStringAsFixed(1); // '2.3'
double _valueInDouble = double.parse(inString); // 2.3

TextEditingController productName = TextEditingController();

class _ProductPageState extends State<ProductPage> {
  late var res;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // Set this height
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xffBAB4AE),
              image: DecorationImage(
                  alignment: AlignmentDirectional.topCenter,
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/Group 6.png'))),
        ),
      ),
      backgroundColor: Color(0xffBAB4AE),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: productName,
                    decoration: InputDecoration(
                      hintText: "Product name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.74,
                height: MediaQuery.of(context).size.width * 0.17,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Color(0xff007A7B), width: 2.5)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.07,
              ),
              CustomButton(title: "Scan the UPC", action: () {}),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              Text("Creativity Range",
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "CrimsonText-Regular",
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: MediaQuery.of(context).size.width * 0.05,
                    activeTrackColor: Color(0xff007A7B),
                    inactiveTrackColor: Color.fromARGB(255, 161, 158, 155),
                    thumbColor: _value != 0.0
                        ? Color.fromARGB(255, 166, 160, 155)
                        : Color(0xff007A7B),
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 19.0,
                    ),
                    overlayShape: RoundSliderOverlayShape(
                      overlayRadius: 20.0,
                    ),
                  ),
                  child: Slider(
                    min: 0.0,
                    max: 1.0,
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                        String inString = _value.toStringAsFixed(1); // '2.3'
                        _valueInDouble = double.parse(inString); // 2.3
                        print(_valueInDouble);
                        // print(productName.text);
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.07,
              ),
              CustomButton(
                  title: "Start",
                  action: () async {
                    //  product();
                    print("Response");
                    print("productName" + productName.text);
                    print("value$_valueInDouble");
                    res = await sendRequest(productName.text, _valueInDouble);
                    print(jsonDecode(res.body));
                    start();
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              Image.asset(
                  'assets/images/_Brown and Black Funny Cookies T-Shirt 1.png'),
            ],
          ),
        ),
      ),
    );
  }

  void start() {
    if (productName.text.isNotEmpty)
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => DetailsPage(body: res)));
  }

  Future<http.Response> sendRequest(String pName, double range) async {
    return await http.post(
      Uri.parse('https://wonderwrap-fjkb7.ondigitalocean.app/ai/ask_gpt_oreo/'),
      headers: {'Content-Type': 'application/json'},
      body:
          jsonEncode(<String, Object>{"product": pName, "temperature": range}),
    );
  }
}
