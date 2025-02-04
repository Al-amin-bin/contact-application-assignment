import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _name= TextEditingController();
  final TextEditingController _contactNumber= TextEditingController();
   Map<String, String> contactMap = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 30, color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person)
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return "Please Enter Name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),
              TextFormField(
                validator: (String? value){
                  if(value!.isEmpty || value.length != 11 ){
                    return "Enter valid Number";
                  }
                  return null;
                },
                controller: _contactNumber,
                decoration: InputDecoration(
                    hintText: "Contact Number",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.contact_page)
                ),
              ),
              SizedBox(height: 12,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                      if(_key.currentState!.validate()){
                        setState(() {
                          String key = _name.text.trim();
                          String value = _contactNumber.text.trim();
                          contactMap[key]= value;
                        });
                      
                        _name.clear();
                        _contactNumber.clear();

                      }

                    },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder()
                ),
                    child:  Text("ADD",style:TextStyle(color: Colors.white),)),
              ),
              SizedBox(height: 12,),

              Expanded(
                child: ListView.builder(
                    itemCount: contactMap.length,
                    itemBuilder: (context,index){
                      String key = contactMap.keys.elementAt(index);
                      String value = contactMap[key]!;
                      return Card(
                        child: ListTile(
                          onLongPress:(){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirmation"),
                                  content: Text("Are You Sure for Delete?"),
                                  actions: [
                                    IconButton(onPressed: (){
                                      setState(() {

                                        Navigator.pop(context);
                                      });


                                    },
                                        icon: Icon(Icons.delete_forever_outlined)),
                                    IconButton(
                                        onPressed: (){
                                          setState(() {
                                            contactMap.remove(key);
                                            Navigator.pop(context);
                                          });
                                        },
                                        icon:Icon(Icons.delete)),

                                  ],
                                );
                              },
                            );
                          },
                          title: Text(key,style: TextStyle(fontSize: 16, color: Colors.red),),
                          subtitle: Text(value),
                          shape: RoundedRectangleBorder(),
                          leading: Icon(Icons.person),
                          trailing: Icon(Icons.call,color: Colors.blue,),
                        
                        ),
                      );

                }),
              )
            ],
          ),
        ),
      )
    );
  }
}


