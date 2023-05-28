part of '../screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LeftSection(),
          RightSection(),
        ],
      ),
    );
  }
}

class LeftSection extends StatelessWidget {
  const LeftSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("../lib/assets/login-bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 100, right: 150, left: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to Naraya Vision",
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Clarity gives you the blocks & components you need to create a truly professional website.",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("../lib/assets/login.png"),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RightSection extends StatelessWidget {
  const RightSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 100, right: 100, left: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Clarity gives you the blocks and components you need to create a truly professional website.",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              "Email address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Color.fromARGB(33, 108, 78, 255),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color.fromARGB(255, 108, 78, 255),
                  width: 1,
                ),
              ),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: Color.fromARGB(33, 108, 78, 255),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color.fromARGB(255, 108, 78, 255),
                  width: 1,
                ),
              ),
              child: TextField(
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //buat checkbox
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Remember me"),
                  ],
                ),
                Text(
                  "Forgot password?",
                  style: TextStyle(color: Color(0xff6B4EFF)),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xff6B4EFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text("Don't have an account?"),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Create free account",
                  style: TextStyle(color: Color(0xff6B4EFF)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
