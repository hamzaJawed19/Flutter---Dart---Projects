import 'dart:io';

void main() {
  print(
      "-------------------------------------------------------------------------------");
  print(
      "**************************** ''WELCOME HOSPITAL MANAGEMENT SYSTEM'' ******************");
  print(
      "------------------------------------------------------------------------------------");
  int choice;
  do {
    displayMenu();
    print('Enter your choice:');
    choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        doctorAdminPanel();
        break;
      case 2:
        PatientAdminPanel();
        break;
      case 3:
        exit(0);
      default:
        print('Invalid Choice...');
    }
  } while (choice != 4);
}

void displayMenu() {
  print("1.) Doctors ");
  print("2.) Patient");
  print("3.) Exit");
}

void displayPatMenu() {
  print('1.) Add Patient');
  print('2.) Display All Patients');
  print('3.) Search Patient');
  print('4.) Select Doctor For Appointment');
  print('5.) View Bill');
  print('6.) Back');
}

void PatientAdminPanel() {
  print(
      "--------------------------------------------------------------------------------");
  print("**************************** ADMIN PANEL ******************");
  print(
      "--------------------------------------------------------------------------------");
  print("                      **PATIENT SECTION**");
  print(
      "--------------------------------------------------------------------------------");
  Hospital patient = Hospital();
  Doctor doc = Doctor.empty();

  List<Patient> patients = [];
  int choice;
  do {
    displayPatMenu();
    print('Enter your choice:');
    choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        patient.addPatient(patients);
        break;
      case 2:
        patient.displayAllPatients(patients);
        break;
      case 3:
        patient.searchPatient(patients);
        break;
      case 4:
        Bill bill = Bill.empty();
        List<Doctor> doctors = [];
        patient.ExistingDoctors(doctors);
        doc = bill.doctorSelection(doctors)!;
        break;
      case 5:
        Bill bill = Bill.empty();
        bill.generateBill(patients, doc);
        break;
    }
  } while (choice != 6);
}

void doctorAdminPanel() {
  print(
      "--------------------------------------------------------------------------------");
  print("**************************** ADMIN PANEL ******************");
  print(
      "--------------------------------------------------------------------------------");
  print("                      **DOCTOR SECTION**");
  print(
      "--------------------------------------------------------------------------------");
  int c1, s1 = 1;
  List<Doctor> doctors = [];
  do {
    print("1.Add New doctor\n2.Existing Doctors List");
    print('Enter your choice:');
    c1 = int.parse(stdin.readLineSync()!);
    switch (c1) {
      case 1:
        {
          Hospital doc = Hospital();
          doc.addDoctorsList(doctors);
        }
        break;
      case 2:
        {
          Hospital doc = Hospital();
          doc.ExistingDoctors(doctors);
          doc.displayDoctorInfo(doctors);
          break;
        }
    }
    print("\n1.) Return to Back \n0.) Main Menu");
    print('Enter your choice:');
    s1 = int.parse(stdin.readLineSync()!);
  } while (s1 == 1);
}

class Doctor extends Person {
  late String specialization;
  late double Fees;

  Doctor(String name, String gender, int age, this.specialization, this.Fees)
      : super(name, gender, age);

  Doctor.empty() : super.empty();

  void displayInfo() {
    print("-------------------------------------------");
    print('Name: $name');
    print('Age: $age');
    print('Gender: $gender');
    print('Specialization: $specialization');
    print('Fees: $Fees');
    print("-------------------------------------------");
  }
}

class Patient extends Person {
  late String disease;
  late Doctor doctor;

  Patient(String name, String gender, int age, this.disease)
      : super(name, gender, age);

  Patient.empty() : super.empty();

  void displayInfo() {
    print('Name: $name');
    print('Age: $age');
    print('Gender: $gender');
    print('Disease: $disease');
  }
}

class Hospital {
  //Doctors Details
  List<Doctor> ExistingDoctors(List<Doctor> doctors) {
    Doctor doctor1 = Doctor("Dr Ali", "Male ", 25, "General Physician", 300);
    Doctor doctor2 = Doctor("Dr basit", "Male ", 35, "Orthopadic ", 1000);
    Doctor doctor3 = Doctor("Dr Abbas", "Male ", 30, " RMD ", 2000);
    doctors.add(doctor1);
    doctors.add(doctor2);
    doctors.add(doctor3);
    return doctors;
  }

  void addDoctorsList(List<Doctor> doctors) {
    print("-------------------------");
    print('Enter Doctor details:');
    print("-------------------------");
    print('Name:');
    String name = stdin.readLineSync()!;
    print('Age:');
    int age = int.parse(stdin.readLineSync()!);
    print('Gender:');
    String gender = stdin.readLineSync()!;
    print('specialization:');
    String specialization = stdin.readLineSync()!;
    print('fees:');
    double fees = double.parse(stdin.readLineSync()!);
    Doctor doct = Doctor(name, gender, age, specialization, fees);
    doctors.add(doct);
    print("-------------------------------------------");
    print("Doctor Added Successfully !!!!!!!!!!!   ");
    print("-------------------------------------------");
  }

  void displayDoctorInfo(List<Doctor> doctors) {
    for (Doctor doc in doctors) {
      print("-------------------------------------------");
      print('Name: ${doc.name}');
      print('Age: ${doc.age}');
      print('Gender: ${doc.gender}');
      print('Specialization: ${doc.specialization}');
      print('Fees: ${doc.Fees}');
      print("-------------------------------------------");
    }
  }

  //Patient Details
  void addPatient(List<Patient> patients) {
    print('Enter patient details:');
    print('Name:');
    String name = stdin.readLineSync()!;
    print('Age:');
    int age = int.parse(stdin.readLineSync()!);
    print('Gender:');
    String gender = stdin.readLineSync()!;
    print('Disease:');
    String disease = stdin.readLineSync()!;
    Patient patient = Patient(name, gender, age, disease);
    patients.add(patient);
  }

  void displayAllPatients(List<Patient> patients) {
    if (patients.isEmpty) {
      print('No patients found');
    } else {
      print('List of all patients:');
      print('---------------------------------');
      for (Patient patient in patients) {
        patient.displayInfo();
        print('---------------------------------');
      }
      print('************************************');
    }
  }

  void searchPatient(List<Patient> patients) {
    bool found = false;
    print("Enter patient Name: ");
    String name = stdin.readLineSync()!;
    for (Patient patient in patients) {
      if (patient.name == name) {
        patient.displayInfo();
        found = true;
        break;
      }
    }
    if (!found) {
      print('Patient not found');
    }
  }
}

class Bill {
  late Doctor doctor;
  late Patient patient;
  Hospital hospital = Hospital();

  Bill(this.doctor, this.patient);
  Bill.empty();

  Doctor? doctorSelection(List<Doctor> doctor) {
    print("*********DOCTORS LIST***********");
    hospital.displayDoctorInfo(doctor);
    print("********************************");

    print("Enter Doctor Name: ");
    String name = stdin.readLineSync()!;

    for (Doctor doc in doctor) {
      if (doc.name == name) {
        print("********************************");
        print("**     DOCTORS SELECTED !!!!  **");
        print("********************************");
        return doc;
      }
    }

    return null;
  }

  void generateBill(List<Patient> patient, Doctor doc) {
    if (patient.isEmpty) {
      print('First ADD Patient');
    } else {
      final date = DateTime.now().toString().substring(0, 10);
      print(
          "\n\n================================================================");
      print("**************************** WELCOME HOSPITAL ******************");
      print(" \n\t\t\t       Bill Receipt  ");
      print("  \t\t\t       ------------ ");
      print("================================================================");
      print("Recipt NO : 1                                   Date:$date ");
      print(" ");
      print(" ---------------------------------------------------- ");
      print("     Patient               ||         Doctor ");
      print(" ---------------------------------------------------- ");
      print("\nName: ${patient.first.name}                || Name: ${doc.name}" +
          "\nAge: ${patient.first.age}                    || Specialization: ${doc.specialization}" +
          "\nDisease: ${patient.first.disease}                 ");
      print("------------------------------------------------------ ");
      print(" ");
      print("                                              ------------------");
      print(
          "                                              |Amount :${doc.Fees}   |");
      print("                                              ------------------");
      print("================================================================");
      print("================================================================");
    }
  }
}

abstract class Person {
  late String name;
  late String gender;
  late int age;

  Person(this.name, this.gender, this.age);

  Person.empty() {}

  void displayInfo();
}
