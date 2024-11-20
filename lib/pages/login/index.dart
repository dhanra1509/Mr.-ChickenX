import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:mr_chicken_x/constants/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isOtpSent = false;
  bool isTimerRunning = false;  // To check if the timer is running
  int remainingTime = 300;  // 5 minutes in seconds
  late Timer _timer;
  late TextEditingController _controller = TextEditingController();

  void _startTimer() {
    setState(() {
      isTimerRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        _timer.cancel();
        setState(() {
          isTimerRunning = false;
        });
      }
    });
  }

  void _submitOtp(String otp) {
    if (otp.length == 6) {
      print("OTP Entered: $otp");
      // Perform OTP verification here
    }
  }

  void _goBackToMobileInput() {
    setState(() {
      isOtpSent = false;
      remainingTime = 300;  // Reset timer when going back to mobile input
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colors.lemon,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Theme.of(context).colors.lemon),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Section with Logo and Graphics
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: Theme.of(context).colors.lemon,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/chicken.png', // Add chicken image asset path
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Mr. ChickenX',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colors.persianred,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // AnimatedSwitcher for Transitioning Views
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Custom transition: Slide transition for views
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0), // Start from right
                    end: Offset.zero, // Move to the current position
                  ).animate(animation),
                  child: child,
                );
              },
              child: isOtpSent
                  ? _buildOtpView()  // OTP View
                  : _buildMobileNumberView(), // Mobile Number Input View
            ),
          ],
        ),
      ),
    );
  }

  // Mobile Number Input Section
  Widget _buildMobileNumberView() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Enter Mobile Number',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colors.paleSpring,
              hintText: 'Mobile Number',
              hintStyle: const TextStyle(color: Colors.black54),
              prefixIcon: const Icon(Icons.phone, color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isOtpSent = true;
                });
                _startTimer();  // Start the timer when OTP is sent
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colors.persianred,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Send OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // OTP Input Section
  Widget _buildOtpView() {
    return Column(
      children: [
        // Positioned back button on top
        // Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: Align(
        //     alignment: Alignment.topLeft,
        //     child: Container(
        //       width: 40,
        //       height: 40,
        //       decoration: BoxDecoration(
        //         color: const Color(0xFFD32F2F),
        //         borderRadius: BorderRadius.circular(25),
        //       ),
        //       child: IconButton(
        //         icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        //         onPressed: _goBackToMobileInput,
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 60), // Adjust spacing between back button and text
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Enter 6 digits verification code sent to your number',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 20),
        OtpTextField(
          autoFocus: true,
          numberOfFields: 6,
          fieldWidth: 45,
          focusedBorderColor: Theme.of(context).colors.persianred,
          filled: true,
          fillColor: Theme.of(context).colors.paleSpring,
          showFieldAsBox: true,
          textStyle: const TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          onSubmit: _submitOtp,
        ),
        const SizedBox(height: 20),
        isTimerRunning
            ? Text(
                'Resend in ${remainingTime ~/ 60}:${remainingTime % 60 < 10 ? '0' : ''}${remainingTime % 60} min',
                style: const TextStyle(color: Colors.black),
              )
            : InkWell(
                onTap: () {
                  // Handle OTP resend functionality here
                  print("Retry OTP pressed");
                  setState(() {
                    remainingTime = 300;  // Reset time
                  });
                  _startTimer();  // Restart the timer
                },
                child: Text(
                  'Resend OTP',
                  style: TextStyle(color: Theme.of(context).colors.persianred),
                ),
              ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Handle OTP confirmation logic here
                print("Confirm OTP pressed");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colors.persianred,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text.rich(
            TextSpan(
              text: 'Not your mobile number? ',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
              children: [
                TextSpan(
                    text: 'Click here',
                    style: TextStyle(color: Theme.of(context).colors.persianred),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle the click action here
                        _goBackToMobileInput();
                      }),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
