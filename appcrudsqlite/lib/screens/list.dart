import 'package:appcrudsqlite/data/dbgeek.dart';
import 'package:flutter/cupertino.dart'; 

import 'package:flutter/material.dart'; 

import 'package:appcrudsqlite/screens/edit.dart'; 

  

class ListProduto extends StatefulWidget { 

  @override 

  State<StatefulWidget> createState() { 

    return _ListProduto(); 

  } 

} 

  

class _ListProduto extends State<ListProduto> { 

  List<Map> slist = []; 

  DBgeek mydb = DBgeek(); 

  

  @override 

  void initState() { 

    mydb.open(); 

    getdata(); 

    super.initState(); 

  } 

  

  getdata() { 

    Future.delayed(Duration(milliseconds: 500), () async { 

      //use delay min 500 ms, because database takes time to initilize. 

      slist = await mydb.db.rawQuery('SELECT * FROM books'); 

  

      setState(() {}); //refresh UI after getting data from table. 

    }); 

  } 

  

  @override 

  Widget build(BuildContext context) { 

    return Scaffold( 

      appBar: AppBar( 

        title: Text("Lista de Produtos Cadastrados"), 

      ), 

      body: SingleChildScrollView( 

        child: Container( 

          child: slist.length == 0 

              ? Text("Carregando Produtos") 

              : //show message if there is no any student 

              Column( 

                  //or populate list to Column children if there is student data. 

                  children: slist.map((stuone) { 

                    return Card( 

                      child: ListTile( 

                        leading: Icon(Icons.people), 

                        title: Text(stuone["nome"]), 

                        subtitle: Text("NomeProduto:" + 

                            stuone["roll_no"].toString() + 

                            ", precoProduto: " + 

                            stuone["Preço"]), 

                        trailing: Wrap( 

                          children: [ 

                            IconButton( 

                                onPressed: () { 

                                  //Navigator.push(context, MaterialPageRoute( 
                                      //builder: (BuildContext context) { 

                                    //return EditProduto(rollno: stuone["roll_no"]); 

                                  //})); //navigate to edit page, pass student roll no to edit 

                                }, 

                                icon: Icon(Icons.edit)), 

                            IconButton( 

                                onPressed: () async { 

                                  await mydb.db.rawDelete( 

                                      "DELETE FROM Produtos WHERE roll_no = ?", 

                                      [stuone["roll_no"]]); 

                                  //delete student data with roll no. 

                                  print("Data Deleted"); 

                                  ScaffoldMessenger.of(context).showSnackBar( 

                                      SnackBar(content: Text("Produto Apagado!"))); 

                                  getdata(); 

                                }, 

                                icon: Icon(Icons.delete, color: Colors.red)) 

                          ], 

                        ), 

                      ), 

                    ); 

                  }).toList(), 

                ), 

        ), 

      ), 

    ); 

  } 

} 