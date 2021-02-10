import 'package:flutter/material.dart';
import 'package:my_health/pageAssets.dart';

class Register extends StatefulWidget {
  static const String id = 'registerPage';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final List<ListItem> _dropdownItems = [
    ListItem(1, "Male"),
    ListItem(2, "Female"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 130,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 50.0),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 46.0,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_back,color: Colors.white,),
                      iconSize: 30.0,
                      onPressed: (){
                        Navigator.pop(context);
                      }
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.79,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: mainColor.withOpacity(1.0),
                      spreadRadius: 10,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      RegisterNameTextField(),
                      SizedBox(
                        height: 20.0,
                      ),
                      RegisterUserNameTextField(),
                      SizedBox(
                        height: 20.0,
                      ),
                      RegisterPasswordTextField(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Container(
                          width: 370.0,
                          height: 58.0,
                          padding: EdgeInsets.fromLTRB(50, 1, 20, 1),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              border: Border.all(width: 0.7,
                                color: Colors.grey[700],)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey[800],
                                ),
                                hint: Text("Select Gender"),
                                value: _selectedItem,
                                items: _dropdownMenuItems,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedItem = value;
                                  });
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(child: DOBPicker()),
                      SizedBox(
                        height: 25.0,
                      ),
                      Center(
                        child: PageButtons(
                          buttonTitle: "Register",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
DateTime dateTime;
// ignore: must_be_immutable
class DOBPicker extends StatefulWidget {

  @override
  _DOBPickerState createState() => _DOBPickerState();
}

class _DOBPickerState extends State<DOBPicker> {
  @override
  Widget build(BuildContext context) {
    String birthDateInString;
    DateTime birthDate;
    bool isDateSelected = false;
    return Container(
      child: InkWell(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2077),
          ).then((date) {
            setState(() {
               dateTime = date;
            });
          });
        },
        child: Container(
          width: 370.0,
          height: 58.0,
          decoration: BoxDecoration(
              border: Border.all(
                width: 0.7,
                color: Colors.grey[700],
              ),
              borderRadius:
              BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 18.0, top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    dateTime == null
                        ? "Select Date of Birth"
                        : "Date of Birth: ${dateTime.year}-${dateTime.month}-${dateTime.day}",
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.grey[800]),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//list for gender picker
class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

//TextField for Name
class RegisterNameTextField extends StatefulWidget {
  @override
  _RegisterNameTextFieldState createState() => _RegisterNameTextFieldState();
}

class _RegisterNameTextFieldState extends State<RegisterNameTextField> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  FocusNode focusNodeName = FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
        focusNode: focusNodeName,
        decoration: InputDecoration(
          labelText: "Name",
          labelStyle: TextStyle(
              color: focusNodeName.hasFocus ? mainColor : Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

//TextField for UserName
class RegisterUserNameTextField extends StatefulWidget {
  @override
  _RegisterUserNameTextFieldState createState() =>
      _RegisterUserNameTextFieldState();
}

class _RegisterUserNameTextFieldState extends State<RegisterUserNameTextField> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  FocusNode focusNodeUserName = FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
        focusNode: focusNodeUserName,
        decoration: InputDecoration(
          labelText: "UserName",
          labelStyle: TextStyle(
              color: focusNodeUserName.hasFocus ? mainColor : Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

//TextField for PasswordCredential
class RegisterPasswordTextField extends StatefulWidget {
  @override
  _RegisterPasswordTextFieldState createState() =>
      _RegisterPasswordTextFieldState();
}

class _RegisterPasswordTextFieldState extends State<RegisterPasswordTextField> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  FocusNode focusNodePassword = FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
        focusNode: focusNodePassword,
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(
              color: focusNodePassword.hasFocus ? mainColor : Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
