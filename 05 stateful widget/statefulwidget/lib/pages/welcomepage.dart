import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WelcomePageState();
  }
}

class WelcomePageState extends State {
  String name="";
  String lastname="";
  String saludo="";

  @override
  Widget build(BuildContext context) {

    void handleNameChanged(String value){
      name=value;
      print(name);
      setState(() {});
    }
    void handleLastnameChanged(String value){
      lastname=value;
      print(lastname);
      setState(() {});
    }
    void handleSubmit(){
      saludo="bienvenido $name $lastname";
      setState(() {});
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
        children: [
          const Text("Ingrese su nombre:"),
          TextField(onChanged: (value){handleNameChanged(value);},),
          const Text("Ingrese su apellido:"),
          TextField(onChanged: (value){handleLastnameChanged(value);},),
          MaterialButton(onPressed: handleSubmit, child: const Text("Enviarr!")),
          SizedBox(height: 20,),
          Text(saludo, style: TextStyle(fontSize: 20),  ),    
        ],
      
      ),
      

      
      )
    );
  }
}
