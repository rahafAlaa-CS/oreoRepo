import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oreo_app/components/custom_button.dart';
import 'package:oreo_app/components/custom_send_buttom.dart';
import 'package:oreo_app/view/product_page.dart';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final body;
  const DetailsPage({super.key, required this.body});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController Email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // Set this height
        child: Container(
          child: Align(
            alignment: Alignment(-0.9, 0.01),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffBAB4AE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => ProductPage()));
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ),
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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text("Word descriptions.",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: "CrimsonText-Regular",
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        ...List.generate(
                            widget.body.length,
                            (index) => Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.001,
                                    ),
                                    Text(
                                      widget.body[index].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        fontFamily: "CrimsonText-Regular",
                                      ),
                                    )
                                  ],
                                ))
                      ]),
                ),
                height: MediaQuery.of(context).size.height * 0.46,
                width: MediaQuery.of(context).size.height * 0.41,
                decoration: BoxDecoration(
                  color: Color(0xff007A7B),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  title: "E-mail Export data",
                  action: () {
                    showPopup(context);
                  }),
              Image.asset(
                'assets/images/_Brown and Black Funny Cookies T-Shirt 1.png',
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.height * 0.27,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Color(0xff007A7B),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.09),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: Email,
                            decoration: InputDecoration(
                              hintText: "Enter E-mail",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        width: 275,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: Color(0xffBAB4AE), width: 2.5)),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08),
                      CustomSendButton(
                          title: "Send",
                          action: () async {
                            var res = await sendToEmail(
                                Email.text, widget.body, productName.text);
                            print("${res.statusCode}");
                            Navigator.pop(context);
                          }),
                    ]),
              ),
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Color(0xff007A7B),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          );
        });
  }

  Future<http.Response> sendToEmail(String pName, body, String email) async {
    return await http.post(
      Uri.parse(
          'https://wonderwrap-fjkb7.ondigitalocean.app/ai/send_product_data_via_email/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          <String, Object>{"words": body, "product": pName, "email": email}),
    );
  }
}

void mapToList(var x) async {
  await x.forEach((K, V) {
    list.add(Item(K, V));
    for (int i = 0; i < V.length; i++) {
      print('--------------${V[i]}');
    }
  });
}

class Item {
  String name;
  var list = [];

  Item(this.name, this.list);
}
