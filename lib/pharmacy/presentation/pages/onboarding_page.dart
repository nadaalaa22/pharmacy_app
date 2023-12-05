import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var x = constraints.maxHeight ;
        return Scaffold(
          backgroundColor: const Color(0xfff2e9e2),
          appBar: AppBar(
            backgroundColor: const Color(0xffe4d4c5),
            title: const Center(
              child: Text(
                ' M\'s Remedies',
                style: TextStyle(fontSize: 24, fontFamily: 'MyFont'),
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/laurynas-mereckas-1TL8AoEDj_c-unsplash.jpg',
                height: x/3,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Welcome to M\'s Remedies',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'MyFont'),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Homeopathy is a complementary medicine founded by the German physicist Samuel Hahnemann in the 1790s.'
                      ' It relies on the principle of "like cures like", meaning a'
                      ' substance given in small dose to an ill person treats the'
                      ' symptoms that in large doses it would induce in a'
                      ' healthy person. Thus in practice it consists of remedies'
                      'that are potentised, meaning they have been subjected'
                      'to repeated dilution and succession. These remedies'
                      'should in turn stimulate the bodies own healing abilities.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffe4d4c5)),
                  child: MaterialButton(
                    onPressed: () {},
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'MyFont'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
