import 'package:dnagkung/constants/common_size.dart';

import 'package:dnagkung/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

const duration = Duration(microseconds: 300);

class _AuthPageState extends State<AuthPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  TextEditingController _phoneNumberController =
      TextEditingController(text: "010");

  TextEditingController _codeController = TextEditingController();

  final inputBorder =
      OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));

  String? _verificationId;
  int? _forceResendingToken;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size size = MediaQuery.of(context).size;
        return IgnorePointer(
          ignoring: _verificationStatus == VerificationStatus.verifying,
          child: Form(
            key: _formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Text('전화번호 로그인',
                    style: Theme.of(context).appBarTheme.titleTextStyle),
              ),
              body: Padding(
                padding: const EdgeInsets.all(common_padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        ExtendedImage.asset(
                          'assets/imgs/padlock.png',
                          width: size.width * 0.15,
                          height: size.width * 0.15,
                        ),
                        SizedBox(
                          width: common_sm_padding,
                        ),
                        Text(
                            '''토마토마켓은 휴대폰 번호로 가입해요.\n번호는 안전하게 보관되며\n어디에도 공개되지 않아요.'''),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [MaskedInputFormatter("000 0000 0000")],
                      decoration: InputDecoration(
                          focusedBorder: inputBorder, border: inputBorder),
                      validator: (phoneNumber) {
                        if (phoneNumber != null && phoneNumber.length == 13) {
                          return null;
                        } else {
                          //error
                          return '전화번호를 다시 확인하고 입력하세요.';
                        }
                      },
                    ),
                    SizedBox(
                      height: common_padding,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_verificationStatus ==
                            VerificationStatus.codeSending) return;
                        // _getAddress();
                        if (_formKey.currentState != null) {
                          bool passed = _formKey.currentState!.validate();
                          print(passed);
                          if (passed) {
                            String phoneNum = _phoneNumberController.text;
                            phoneNum = phoneNum.replaceAll(' ', '');
                            phoneNum = phoneNum.replaceFirst('0', '');

                            FirebaseAuth auth = FirebaseAuth.instance;

                            setState(() {
                              _verificationStatus =
                                  VerificationStatus.codeSending;
                            });

                            await auth.verifyPhoneNumber(
                              phoneNumber: '+82$phoneNum',
                              forceResendingToken: _forceResendingToken,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) async {
                                // ANDROID ONLY!

                                // Sign the user in (or link) with the auto-generated credential
                                await auth.signInWithCredential(credential);
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                              codeSent: (String verificationId,
                                  int? forceResendingToken) async {
                                setState(() {
                                  _verificationStatus =
                                      VerificationStatus.codeSent;
                                });
                                _verificationId = verificationId;
                                _forceResendingToken = forceResendingToken;
                              },
                              verificationFailed:
                                  (FirebaseAuthException error) {
                                logger.e(error.message);
                                setState(() {
                                  _verificationStatus = VerificationStatus.none;
                                });
                              },
                            );
                          }
                          // setState(() {
                          //   _verificationStatus = VerificationStatus.codeSent;
                          // });
                        }
                      },
                      child: (_verificationStatus ==
                              VerificationStatus.codeSending)
                          ? SizedBox(
                              width: 26,
                              height: 26,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text('인증문자 발송'),
                    ),
                    SizedBox(
                      height: common_padding,
                    ),
                    AnimatedOpacity(
                      duration: Duration(microseconds: 300),
                      curve: Curves.easeInOut,
                      opacity: (_verificationStatus == VerificationStatus.none)
                          ? 0
                          : 1,
                      child: AnimatedContainer(
                        duration: duration,
                        curve: Curves.easeInOut,
                        height: getVerificationHeight(_verificationStatus),
                        child: TextFormField(
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [MaskedInputFormatter("000000")],
                          decoration: InputDecoration(
                              focusedBorder: inputBorder, border: inputBorder),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: duration,
                      curve: Curves.easeInOut,
                      height: getVerificationButtonHeight(_verificationStatus),
                      child: TextButton(
                        onPressed: () {
                          attemptVerify(context);
                        },
                        child: (_verificationStatus ==
                                VerificationStatus.verifying)
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text('인증'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double getVerificationHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSending:

      case VerificationStatus.codeSent:

      case VerificationStatus.verifying:

      case VerificationStatus.verificationDone:
        return 60 + common_padding;
    }
  }

  double getVerificationButtonHeight(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSending:
      case VerificationStatus.codeSent:

      case VerificationStatus.verifying:

      case VerificationStatus.verificationDone:
        return 48;
    }
  }

  void attemptVerify(BuildContext context) async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });
    // Update the UI - wait for the user to enter the SMS code
    String smsCode = '55555';
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: _codeController.text);

      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      logger.e('verification failed!!');
      SnackBar snackbar = SnackBar(content: Text('입력 코드가 다르네요?!'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      _codeController.clear();
    }
    setState(() {
      _verificationStatus = VerificationStatus.verificationDone;
    });
  }

  _getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString('address') ?? "";
    logger.d('Address from shared pref - $address');
  }
}

enum VerificationStatus {
  none,
  codeSending,
  codeSent,
  verifying,
  verificationDone
}
