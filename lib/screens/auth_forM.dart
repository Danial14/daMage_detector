import 'package:damage_detector/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class AuthForM extends StatefulWidget{
  @override
  AuthForMState createState() {
    return AuthForMState();
  }
}
class AuthForMState extends State{
  String _eMail = "";
  String _password = "";
  String _userNaMe = "";
  bool _isLoading = false;
  var _forMKey = GlobalKey<FormState>();
  void _subMit() async{
    bool isValid = _forMKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _forMKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _eMail, password: _password);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          return HomeScreen();
        }));
      } on FirebaseAuthException catch(err){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.message!)));
      }
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.yellowAccent.shade400,
        body : Container(
      height: MediaQuery.of(context).size.height * 80 / 100,
      child: Card(
        margin: EdgeInsets.only(top: 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.4, 0.7],
                tileMode: TileMode.repeated,
              )),
          child: Form(
          key: _forMKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    "Signup",
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: "Lobster"
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty || !value.contains("@")){
                      return "Please enter valid email address";
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    icon: Icon(
                        Icons.email
                    ),
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontFamily: "Pacifico"
                  ),
                  onSaved: (value){
                    _eMail = value!;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter a valid username";
                    }
                    else if(value.length < 6){
                      return "User name should be of atleast six characters";
                    }
                  },
                  onSaved: (value){
                    _userNaMe = value!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    icon: Icon(
                        Icons.person
                    ),
                    labelText: "Username",
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontFamily: "Pacifico"
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter a valid password";
                    }
                    else if(value.length < 6){
                      return "Password should be of atleast six characters";
                    }
                  },
                  onSaved: (value){
                    _password = value!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    icon: Icon(
                        Icons.password
                    ),
                    labelText: "Password",
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: TextStyle(
                      fontFamily: "Pacifico"
                  ),
                ),
                SizedBox(height: 10,),
                if(_isLoading)
                  CircularProgressIndicator()
                else
                 ElevatedButton(onPressed: _subMit, child: Text("Signup", style: TextStyle(
                  fontFamily: "Lobster",
                  fontSize: 20
                ),), style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                  fixedSize: Size(200, 0)
                ),),
                SizedBox(height: 10,),
                TextButton(child: Text("Already have account? Login", style: TextStyle(
                    fontFamily: "Pacifico"
                ),
                ),
                 onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
                    return Login();
                  }));
                 },
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),),
      ),
    )
    );
  }
}