import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final String SearchType; // Add a parameter for the profile type

  SearchPage(this.SearchType); // Constructor with a required parameter


  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Image.network(
                'https://img.freepik.com/free-photo/potted-plant-yellow-painted-aluminum-can-white-desk_23-2147920701.jpg?size=626&ext=jpg&ga=GA1.1.2106265637.1679766937&semt=ais',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Stack(
                                  children: [
                                    // Implement the stroke
                                    Text(
                                      'Indoor Garden',
                                      style: TextStyle(
                                        fontSize: 45,
                                        letterSpacing: 5,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 10
                                          ..color = Colors.green,
                                      ),
                                    ),
                                    // The text inside
                                    const Text(
                                      'Indoor Garden',
                                      style: TextStyle(
                                        fontSize: 45,
                                        letterSpacing: 5,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffeef1e4),
                                      ),
                                    ),
                                  ],
                                )),



                            // Text(
                            //   'Indoor Garden',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     fontFamily: 'Poppins',
                            //     color: Color(0xffeef1e4),
                            //     letterSpacing: 5,
                            //     fontSize: 40,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffeef1e4),
                              minimumSize: const Size(180, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Get Data',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.green,
                                    fontSize: 25,fontWeight: FontWeight.w900
                                )),

                            /*  child: Container(
                              child: Text('Get Data',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.green,
                                  )),
                              width: 180,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(0xF30B4D19),
                                border: Border.all(
                                    width: 3, color: Color(0xD0111010)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              // borderRadius: BorderRadius.circular(8),
                            ),*/
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Nitrogen',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF0B4E09),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '2.9%',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF0B4E09),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Phosphorus',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF092D08),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '2.1%',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF0B4E09),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Potassium',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF053F04),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '0.3%',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF0B4E09),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Temperature',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF0B4E09),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '23',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF0B4E09),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Humidity',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF092D08),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '66%',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF0B4E09),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Padding(padding:EdgeInsets.all(0),
                            const SizedBox(
                              width: 125,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print('Button pressed ...');
                              },

                              child: Container(
                                  width: 50,
                                  height: 50,
                                  child: const Icon(
                                    Icons.invert_colors,
                                    color: Colors.green,
                                    size: 40,
                                  )
                                //icon: Icon(
                                //Icons.invert_colors,
                                //color: Colors.green,
                                //size: 40,
                              ),

                              //    width: 50,
                              // height: 50,
                            ),

                            ElevatedButton(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              child: Container(
                                child: const Icon(
                                  Icons.wb_incandescent,
                                  color: Colors.green,
                                  size: 40,
                                ),
                                width: 50,
                                height: 50,
                                color: const Color(0x004B39EF),
                              ),
                            ),
                            /*  ElevatedButton.icon(
                              onPressed: (){
                                print("You pressed Icon Elevated Button");
                              },
                              style: ElevatedButton.styleFrom(minimumSize: Size(100, 50),),
                           icon:     Icon(FontAwesomeIcons.fan,
                                  size: 40, //Icon Size
                                  color: Colors.green, //Color Of Icon
                                ), label: Text(''), //label text
                            ),*/

                            ElevatedButton(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              child: const SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.confirmation_number_sharp,
                                  size: 40, //Icon Size
                                  color: Colors.green, //Color Of Icon
                                ),
                                // color: Color(0x004B39EF),
                                //textStyle: FlutterFlowTheme.of(context)
                                //  .subtitle2
                                //.override(
                                //fontFamily: 'Poppins',
                                //color: Colors.green,

                                //borderSide: BorderSide(
                                // color: Color(0x00FFFFFF),
                                //  width: 0,
                                // ),
                                //borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              width: 120,
                            ),

                            ElevatedButton(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                color: const Color(0x004B39EF),
                                child: const Icon(
                                  Icons.bluetooth,
                                  color: Colors.green,
                                  size: 40,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Container(
                                child: const Icon(
                                  Icons.cancel_sharp,
                                  color: Colors.green,
                                  size: 40,
                                ),
                                width: 50,
                                height: 50,
                                color: const Color(0x004B39EF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
