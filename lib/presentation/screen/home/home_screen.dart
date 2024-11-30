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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Visit'),

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
                }
                nameController.clear();
                dniController.clear();
                visitReasonController.clear();
                personToVisitController.clear();
                vehicleController.clear();
                companionsController.clear();
                Navigator.of(context).pop();
              }, 
              

              child: const Text('Add Visit'),
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
    );
  }
}