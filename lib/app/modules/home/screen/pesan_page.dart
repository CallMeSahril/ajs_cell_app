import 'package:flutter/material.dart';

class PesanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      // appBar: AppBar(
      //   backgroundColor: Color(0xffFFFFFF),
      //   title: const Text(''),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xffF0F0F0),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => BuildCardPesan(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildCardPesan extends StatelessWidget {
  const BuildCardPesan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xff93CDFF), borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Text(
                          "karin  salsabila",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text("2199654120"),
                      ],
                    ),
                    Text("12:00"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Selamat siang  kak "),
                    Container(
                      height: 20,
                      width: 20,
                      child: Center(
                          child: Text(
                        "1",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                      decoration: BoxDecoration(
                          color: Color(0xff0B8FAC),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
