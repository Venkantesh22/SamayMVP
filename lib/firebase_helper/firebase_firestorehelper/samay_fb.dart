import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:samay_mvp/constants/global_variable.dart';

class SamayFB {
  static SamayFB instance = SamayFB();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _user = FirebaseAuth.instance;

  Future<int> incrementSalonAppointmentNo() async {
    int newAppointmentNo = 0;

    try {
      // Reference to the document within the nested collection "salon"
      DocumentReference salonDocRef = _firebaseFirestore
          .collection("Samay")
          .doc(GlobalVariable.samayCollectionId)
          .collection("samaySamay")
          .doc(GlobalVariable.salonCollectionId);

      // Use a transaction to ensure atomicity
      await _firebaseFirestore.runTransaction(
        (transaction) async {
          // Get the current value of appointmentNo
          DocumentSnapshot snapshot = await transaction.get(salonDocRef);

          if (!snapshot.exists) {
            throw Exception("Document does not exist!");
          }

          // Get the current appointmentNo value
          int currentAppointmentNo = snapshot.get('appointmentNo');

          // Increment the appointmentNo by 1
          newAppointmentNo = currentAppointmentNo + 1;

          // Update the document with the new appointmentNo
          transaction.update(salonDocRef, {'appointmentNo': newAppointmentNo});
          GlobalVariable.appointmentNO = newAppointmentNo;
          print("Appointment NO $newAppointmentNo");
          print(
              "Appointment NO  GlobalVariable.appointmentNO  ${GlobalVariable.appointmentNO}");
        },
      );
      print("appointmentNo incremented successfully!");

      return newAppointmentNo;
    } catch (e) {
      print("Error incrementing appointmentNo: $e");
      rethrow;
    }
  }
}
