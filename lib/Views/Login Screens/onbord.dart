import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBord extends StatefulWidget {
  const OnBord({super.key});

  @override
  State<OnBord> createState() => _OnBordState();
}

class _OnBordState extends State<OnBord> {
  Color color1 = Colors.white;
  Color color2 = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height * 0.5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/boy.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.4,
                child: Text(
                  'Made With',
                  textAlign: TextAlign.center,
                  style: Get.textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: FlutterLogo(
                  size: 40,
                ),
              ),
              Image.asset(
                'assets/firebase.png',
                scale: 5,
              )
            ],
          ),
          SizedBox(
            width: Get.width * 0.8,
            child: Text(
              'Meet Flutter Community and Experts chat desscuss your problems and more and more',
              textAlign: TextAlign.center,
              style: Get.textTheme.titleSmall!
                  .copyWith(color: const Color.fromARGB(255, 102, 102, 102)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
                width: Get.width * 0.7,
                height: Get.height * 0.07,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          color1 = Colors.white;
                          color2 = Colors.grey[300]!;
                        });
                      },
                      child: AnimatedContainer(
                        child: Center(
                          child: Text(
                            'Login',
                            style: Get.textTheme.headlineLarge!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        duration: Duration(seconds: 1),
                        width: Get.width * 0.35,
                        height: Get.height * 0.65,
                        decoration: BoxDecoration(
                            color: color1,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            color2 = Colors.white;
                            color1 = Colors.grey[300]!;
                          });
                        },
                        child: AnimatedContainer(
                          child: Center(
                            child: Text(
                              'Register',
                              style: Get.textTheme.headlineLarge!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          duration: Duration(seconds: 1),
                          decoration: BoxDecoration(
                              color: color2,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              color1 == Colors.white
                  ? Get.toNamed('/login')
                  : Get.toNamed('/register');
            },
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.bounceIn,
              width: Get.width * 0.35,
              height: Get.height * 0.06,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Go',
                  style: Get.textTheme.headlineLarge,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      )),
    );
  }
}
