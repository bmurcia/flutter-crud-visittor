import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_visitante/domain/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirestoreService _firestoreService = FirestoreService();

  final nameController = TextEditingController();
  final dniController = TextEditingController();
  final visitReasonController = TextEditingController();
  final personToVisitController = TextEditingController();
  final vehicleController = TextEditingController();
  final entryTimeController = TextEditingController();
  final companionsController = TextEditingController();

  void openVisitBox({String? docId}) {

    if (docId != null) {
      FirebaseFirestore.instance.collection('visits').doc(docId).get().then((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data()!;
          setState(() {
            nameController.text = data['name'];
            dniController.text = data['identification'];
            visitReasonController.text = data['visitReason'];
            personToVisitController.text = data['personToVisit'];
            vehicleController.text = data['transportation'];
            companionsController.text = data['companions'];
          });
        } else{
          nameController.clear();
          dniController.clear();  
          visitReasonController.clear();
          personToVisitController.clear();
          vehicleController.clear();
          companionsController.clear();
        }
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(docId == null ? 'Add Visit' : 'Edit Visit'),

          content: SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: dniController,
                decoration: const InputDecoration(labelText: 'DNI'),
              ),
              TextField(
                controller: visitReasonController,
                decoration: const InputDecoration(labelText: 'Razon de Visita'),
              ),
              TextField(
                controller: personToVisitController,
                decoration: const InputDecoration(labelText: 'Persona a quien visita'),
              ),
              TextField(
                controller: vehicleController,
                decoration: const InputDecoration(labelText: 'Vehiculo'),
              ),
              TextField(
                controller: companionsController,
                decoration: const InputDecoration(labelText: 'Acompañantes'),
              ),
            ],
          ),
          ),
          actions: [
            ElevatedButton(
              onPressed: (){
                if (docId == null) {
                  _firestoreService.addVisit(
                    nameController.text,
                    dniController.text,
                    visitReasonController.text,
                    personToVisitController.text,
                    vehicleController.text,
                    entryTimeController.text,
                    companionsController.text,
                  );
                } else {
                  FirebaseFirestore.instance.collection('visits').doc(docId).update({
                    'name': nameController.text,
                    'identification': dniController.text,
                    'visitReason': visitReasonController.text,
                    'personToVisit': personToVisitController.text,
                    'transportation': vehicleController.text,
                    'entryTime': Timestamp.now(),
                    'companions': companionsController.text,
                  });
                }
                nameController.clear();
                dniController.clear();
                visitReasonController.clear();
                personToVisitController.clear();
                vehicleController.clear();
                companionsController.clear();
                Navigator.of(context).pop();
              }, 
              

              child: Text(docId == null ? 'Add Visit' : 'Edit Visit'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome the Visit APP'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openVisitBox();
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirestoreService().getVisits(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List visitList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: visitList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = visitList[index];
                String docId = document.id;
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String nameText = data['name'];

                return ListTile(
                  title: Text(nameText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () => openVisitBox(docId: docId),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: ()=> FirestoreService().deleteVisit(docId),
                      ),
                    ],
                  )

                );
              },
            );
          } else {
            return const Text('No hay visitas');
          }
        },
      ),
    );
  }
}