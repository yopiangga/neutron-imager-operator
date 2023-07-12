part of '../screen.dart';

class DetailPromise extends StatefulWidget {
  const DetailPromise({
    super.key,
    required this.promise,
  });
  final Promise promise;

  @override
  State<DetailPromise> createState() => _DetailPromiseState(promise: promise);
}

class _DetailPromiseState extends State<DetailPromise> {
  _DetailPromiseState({
    required this.promise,
  });

  final Promise promise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          AppBarLogo(),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  "Hey Operator - ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  "here’s what’s happening with your patient today",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          FormPatient(promise: promise),
        ],
      ),
    );
  }
}

class FormPatient extends StatelessWidget {
  FormPatient({
    required this.promise,
    super.key,
  });

  final DetailPromiseService detailPromiseService = DetailPromiseService();
  final Promise promise;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: detailPromiseService.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // print(snapshot.data!['fullname']);
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color.fromARGB(255, 233, 233, 233),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LeftForm(promise: promise),
                RightForm(
                  email: snapshot.data!['email'],
                  name: snapshot.data!['fullname'],
                  promise: promise,
                ),
              ],
            ),
          );
        });
  }
}

class RightForm extends StatelessWidget {
  RightForm({
    required this.name,
    required this.email,
    required this.promise,
    super.key,
  });

  final DetailPromiseService detailPromiseService = DetailPromiseService();
  final String name;
  final String email;
  final Promise promise;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Operator Name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromARGB(255, 233, 233, 233),
                width: 1,
              ),
            ),
            child: Text(name),
          ),
          SizedBox(height: 20),
          Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromARGB(255, 233, 233, 233),
                width: 1,
              ),
            ),
            child: Text(email),
          ),
          SizedBox(height: 20),
          Text(
            "Result CT Scan (DICOM)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          InkWell(
            onTap: () {
              detailPromiseService.uploadImage(promise).then((value) {
                if (value) {
                  print("Upload Success");
                } else {
                  print("Upload Failed");
                }
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromARGB(255, 233, 233, 233),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.file_copy_outlined),
                  SizedBox(height: 5),
                  Text(
                    "Upload File",
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          //beri checkbox
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {},
              ),
              Text(
                "You agree to our friendly privacy policy.",
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Upload success"),
                  ),
                );

                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text("Send result"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff6B4EFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeftForm extends StatelessWidget {
  const LeftForm({
    required this.promise,
    super.key,
  });

  final Promise promise;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Doctor",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            //buat responsive
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromARGB(255, 233, 233, 233),
                width: 1,
              ),
            ),
            child: Text("${promise.doctor.fullname}"),
          ),
          SizedBox(height: 20),
          Text(
            "Time",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromARGB(255, 233, 233, 233),
                width: 1,
              ),
            ),
            child: Text(
                "${DateFormat.yMMMMd().format(DateTime.parse(promise.time))} | ${DateFormat.jm().format(DateTime.parse(promise.time))} PM"),
          ),
          SizedBox(height: 20),
          Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromARGB(255, 233, 233, 233),
                width: 1,
              ),
            ),
            child: Text("${promise.patient.email}"),
          ),
          SizedBox(height: 20),
          Text(
            "Name",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromARGB(255, 233, 233, 233),
                width: 1,
              ),
            ),
            child: Text("${promise.patient.fullname}"),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Place of birth",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    width: MediaQuery.of(context).size.width * 0.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromARGB(255, 233, 233, 233),
                        width: 1,
                      ),
                    ),
                    child: Text("${promise.patient.pob}"),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date of birth",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    width: MediaQuery.of(context).size.width * 0.18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromARGB(255, 233, 233, 233),
                        width: 1,
                      ),
                    ),
                    child: Text(
                        "${DateFormat.yMMMMd().format(DateTime.parse(promise.patient.dob))}"),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "NIK",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromARGB(255, 233, 233, 233),
                width: 1,
              ),
            ),
            child: Text("${promise.patient.nik}"),
          ),
          SizedBox(height: 20),
          // Text(
          //   "Address",
          //   style: TextStyle(fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 5),
          // Expanded(
          //   child: Container(
          //     width: double.infinity,
          //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5),
          //       border: Border.all(
          //         color: Color.fromARGB(255, 233, 233, 233),
          //         width: 1,
          //       ),
          //     ),
          //     child: Text("Jl. Raya Kediri - Pare, Kediri, Jawa Timur"),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(158, 158, 158, 158),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 15),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('../lib/assets/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            "Neutron",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(width: 5),
          Text(
            "Imager",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Color(0xff6B4EFF),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
