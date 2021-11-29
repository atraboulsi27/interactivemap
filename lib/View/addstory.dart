import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddStory extends StatefulWidget {
  const AddStory({Key? key}) : super(key: key);

  @override
  _AddStory createState() => _AddStory();
}

class _AddStory extends State<AddStory> {
  @override
  TextEditingController titleController = new TextEditingController();
  TextEditingController mediatypeController = new TextEditingController();
  String dropdownValue = "Image";
  TextEditingController locationController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController eventdateController = new TextEditingController();
  String _selectedDate = 'Tap to select date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime(1975),
      lastDate: new DateTime(2050),
    );
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMMMMd("en_US").format(d);
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                "Fill Story Information",
                style: TextStyle(
                    color: Colors.brown.shade300,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              width: MediaQuery.of(context).size.width/1.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/1.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLines: 5,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Type of Story",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.brown.shade300,
                      border: Border.all()),
                  child: DropdownButton<String>(
                    elevation: 0,
                    dropdownColor: Colors.brown.shade200,
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Image', 'Voice Note', 'Video']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Colors.black),
                          left: BorderSide(width: 1.0, color: Colors.black),
                          right: BorderSide(width: 1.0, color: Colors.black),
                          bottom: BorderSide(width: 1.0, color: Colors.black),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            child: Text(
                                _selectedDate,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Color(0xFF000000))
                            ),
                            onTap: (){
                              _selectDate(context);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.calendar_today),
                            tooltip: 'Tap to open date picker',
                            onPressed: () {
                              _selectDate(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: 150,
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 40,
                  onPressed: () {},
                  color: Colors.brown.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
