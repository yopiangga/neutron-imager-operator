part of '../screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  final HomeService homeService = HomeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          AppBarSearch(),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  "Hey Operator - ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "here’s what’s happening with your patient today",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: homeService.getAllPromise(),
                builder: (context, snapshot) {
                  // print(snapshot.data);

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<Promise> promise = snapshot.data as List<Promise>;
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 233, 233, 233),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              StatusEmblem(promise: promise[index]),
                              PatientName(
                                  name: promise[index].patient.fullname),
                              DatePromise(time: promise[index].time),
                              Text("${promise[index].hospital.name}"),
                              Text("${promise[index].doctor.fullname}"),
                              ButtonOption(
                                index: index,
                                selectedIndex: selectedIndex,
                                promise: promise[index],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class ButtonOption extends StatelessWidget {
  ButtonOption({
    required this.selectedIndex,
    required this.index,
    required this.promise,
  });
  int index;
  int selectedIndex;
  Promise promise;

  @override
  Widget build(BuildContext context) {
    if (index == selectedIndex) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Center(
                child: Text(
                  "Reject",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPromise(promise: promise),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff6B4EFF),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Center(
                child: Text(
                  "Detail",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Icon(Icons.more_horiz_sharp);
    }
  }
}

class AppBarSearch extends StatelessWidget {
  const AppBarSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        //beri border bawah
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
            "Naraya",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(width: 5),
          Text(
            "Vision",
            style: TextStyle(
                color: Color(0xff6B4EFF),
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          Container(
            //buat search bar
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type to search...',
                icon: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusEmblem extends StatelessWidget {
  StatusEmblem({
    required this.promise,
    super.key,
  });
  final Promise promise;
  Color color = Colors.green;

  @override
  Widget build(BuildContext context) {
    if (promise.status == "pending") {
      color = Colors.amber;
    } else if (promise.status == "rejected") {
      color = Colors.red;
    } else if (promise.status == "uploaded") {
      color = Colors.blue;
    } else {
      color = Colors.green;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 25,
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(25 / 2),
      ),
      child: Center(
        child: Text("${promise.status}", style: TextStyle(color: color)),
      ),
    );
  }
}

class DatePromise extends StatelessWidget {
  DatePromise({
    required this.time,
    super.key,
  });
  String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          //ambil bagian jam dengan format 10:00 am
          "${DateFormat.jm().format(DateTime.parse(time))}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        //ambil bagian tanggal dengan format Apr 24, 2023
        Text("${DateFormat.yMMMMd().format(DateTime.parse(time))}"),
      ],
    );
  }
}

class PatientName extends StatelessWidget {
  const PatientName({
    required this.name,
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text("Man"),
      ],
    );
  }
}
