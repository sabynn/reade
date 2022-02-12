import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reade/cubit/auth_cubit.dart';
import 'package:reade/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reade/ui/pages/sign_in_page.dart';
import '../widgets/custom_button.dart';




class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  Widget build(BuildContext context) {
    var data= [0.0, 3.0, 4.0, 2.0, 1.0];

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(



        actions: [

          SizedBox(width: 10),
          Container(
            width: 90,
            child: Image.asset(
              'assets/images/Profile_icon.png',
              width: 90,
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Color(0xFF002884)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: _mainMenu(context),
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Text(
                      'Analytics',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF002884),
                      ),
                    ),

                    Card(

                      color: Colors.white38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),

                      child: new Sparkline(
                        data:data= [0.0, 3.0, 4.0, 2.0, 1.0],
                        lineColor: Color(0xFF002884),
                        pointsMode: PointsMode.last,
                        pointSize: 9.0,
                        fillMode: FillMode.below,
                        fillGradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF002884),
                            Color(0xFFFFFFFFF)
                          ],
                        ),
                      ),


                    ),

                    Card(
                      color: Colors.white38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: new Sparkline(
                        data:data,
                        lineColor: Color(0xFF002884),
                        pointsMode: PointsMode.last,
                        pointSize: 9.0,
                        fillMode: FillMode.below,
                        fillGradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF002884),
                            Color(0xFFFFFFFFF)
                          ],

                        )
                        ,


                      ),
                    ),
                    Card(
                      color: Colors.white38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: new Sparkline(
                        data:data,
                        lineColor: Color(0xFF002884),
                        pointsMode: PointsMode.last,
                        pointSize: 9.0,
                        fillMode: FillMode.below,
                        fillGradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF002884),
                            Color(0xFFFFFFFFF)
                          ],

                        )
                        ,


                      ),
                    ),
                    Card(
                      color: Colors.white38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),

                      child: new Sparkline(
                        data:data,
                        lineColor: Color(0xFF002884),
                        pointsMode: PointsMode.last,
                        pointSize: 9.0,
                        fillMode: FillMode.below,
                        fillGradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF002884),
                            Color(0xFFFFFFFFF)
                          ],

                        )
                        ,


                      ),
                    ),
                    Card(
                      color: Colors.white38,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: new Sparkline(
                        data:data,
                        lineColor: Color(0xFF002884),
                        pointsMode: PointsMode.last,
                        pointSize: 9.0,
                        fillMode: FillMode.below,
                        fillGradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF002884),
                            Color(0xFFFFFFFFF)
                          ],

                        )
                        ,


                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _learningVideos(String urlImage) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            urlImage,
            width: 200.0,
            height: 300.0,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  Widget _card(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Card(
        color: const Color(0xFFBFDA90),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Main Topic: " + title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: const Color(0xFF3D550C),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: const Color(0xFF8EAF53),
                child: Row(
                  children: <Widget>[
                    for (int i = 0; i < 5; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/profile_pic_students.png',
                          height: 30,
                          width: 30,
                        ),
                      )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );

  }

  Widget _mainMenu(context) {

    return Drawer(
      child: Container(


        decoration: BoxDecoration(

            gradient: LinearGradient(
                begin: Alignment(-1.0, -0.5),
                end: Alignment(1.0, 1.5),
                colors: [Colors.white, Color(0xFF557FED)])
        ),


        width: double.infinity,
        height: double.infinity,



        child: ListView(
          padding: EdgeInsets.zero,

          children: [
            DrawerHeader(
              child: Center(
                child: Container(
                  width: 100,
                  child: Image.asset(
                    'assets/images/Logo.png',
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xFF002884),
                ),
              ),
              leading: const Icon(
                Icons.home,
                color: Color(0xFF002884),
                size: 36.0,
              ),
              onTap: () {},
            ),

            ListTile(
              title: Text(
                'Interview Partner',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF002884),
                ),
              ),
              leading: const Icon(
                Icons.group_add_rounded,
                color: Color(0xFF002884),
                size: 36.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignInPage();
                    },
                  ),
                );
              },
            ),

            ListTile(
              title: Text(
                'Resources',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color:Color(0xFF002884),
                ),
              ),
              leading: const Icon(
                Icons.file_copy_rounded,
                color: Color(0xFF002884),
                size: 36.0,
              ),
              onTap: () {},
            ),

            ListTile(
              title: Text(
                'Result Analytics',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xFF002884),
                ),
              ),
              leading: const Icon(
                Icons.bar_chart_rounded,
                color: Color(0xFF002884),
                size: 36.0,
              ),
              onTap: () {},
            ),

            ListTile(
              title: Text(
                'Meeting Boards',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xFF002884),
                ),
              ),
              leading: const Icon(
                Icons.people_outline_rounded,
                color: Color(0xFF002884),
                size: 36.0,
              ),
              onTap: () {},
            ),

            ListTile(
              title: Text(
                'Logout',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xFF002884),
                ),
              ),
              leading: const Icon(
                Icons.logout_rounded,
                color: Color(0xFF002884),
                size: 36.0,
              ),
              onTap: () {},
            ),


          ],
        ),
      ),
    );
  }
}
class BaseLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}