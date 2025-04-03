import 'package:flutter/material.dart';

class DetailKatagoriView extends StatelessWidget {
  const DetailKatagoriView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(color: Colors.blue),
                  ),
                  Text(
                    "Nama Katagori",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("Rp. 100.000 - Rp. 200.000",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Deskripsi Katagori"),
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 70,
                            color: Colors.grey,
                            margin: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }),
                  ),
                  Text("Descrioption"),
                  Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Row(
                                  children: [
                                    Text("- Layanan ${index + 1}"),
                                  ],
                                ),
                              )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black,
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Jumlah"),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        // Logic to decrease the quantity
                      },
                    ),
                    Text(
                      "0", // Replace with a variable to display the current quantity
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // Logic to increase the quantity
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: () {
              // Add your logic here for button press
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue,
              ),
              child: Text(
                "Masuk Keranjang",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
  }
}
