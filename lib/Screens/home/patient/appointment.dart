import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  final String paId;

  const AppointmentsScreen({Key? key, required this.paId}) : super(key: key);

  Stream<QuerySnapshot> getAppointmentsStream() {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where('patientId', isEqualTo: paId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: getAppointmentsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Check if there are no documents
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No Appointments'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var appointment = snapshot.data!.docs[index];
              return AppointmentCard(
                doctorName: appointment['docterName'],
                doctorType: appointment['docterType'],
                date: appointment['date'].toDate(),
                time: appointment['time'],
              );
            },
          );
        },
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String doctorType;
  final DateTime date;
  final String time;

  const AppointmentCard({
    super.key,
    required this.doctorName,
    required this.doctorType,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Doctor: $doctorName'),
        subtitle: Text('Type: $doctorType\nDate: $date\nTime: $time'),
      ),
    );
  }
}
