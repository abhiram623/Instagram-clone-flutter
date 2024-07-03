import 'package:flutter/material.dart';



class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'https://www.bing.com/images/search?view=detailV2&ccid=QVmbtWeS&id=5A87D43365F0EA868273417BDFECF4BB4FA69C60&thid=OIP.QVmbtWeSgmO2LNdrQhOYEgHaHa&mediaurl=https%3a%2f%2fi5.walmartimages.com%2fasr%2f5d2d639b-fa35-4525-a980-cc44a12b7f78_1.46d6ef8c1c6215c13baf4c1af65186f4.jpeg&exph=1500&expw=1500&q=nike+shoes&simid=608020928709730748&FORM=IRPRST&ck=09FD8548A9F284ADDE5006751DE31362&selectedIndex=9&itb=0', // Replace with your image URL
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nike Air Force',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange),
                Text('4.5 (15 Review)'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              '\$199.00',
              style: TextStyle(
                fontSize: 24,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Nike Dri-Fit is a polyester fabric designed to help you keep dry so you can more comfortably work harder, longer.',
            ),
            SizedBox(height: 16),
            Text(
              'Color:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                ColorOption(Colors.black),
                ColorOption(Colors.orange),
                ColorOption(Colors.blue),
                ColorOption(Colors.orangeAccent),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Size:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: Text('CHOOSE SIZE'),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color color;
  ColorOption(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
        ),
      ),
    );
  }
}