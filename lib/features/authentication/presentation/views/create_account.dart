import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../../../config/routes/route.dart';
import '../../../../config/routes/route_config.dart';
import '../../data/model/user.dart';
import '../change-notifier/auth_notifier.dart';

enum Gender { male, female }

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

// add controllers for validation
class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _form = GlobalKey();
  final Color _gray = const Color.fromRGBO(79, 79, 79, 1);
  Gender _gender = Gender.male;
  bool _hidden = true;
  late TextEditingController _dob;

  @override
  void initState() {
    _dob = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dob.dispose();
    super.dispose();
  }

  _next() {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    Provider.of<AuthNotifier>(context, listen: false).setDetails(
      UserMap.gender,
      _gender.name,
    );

    Application.router.navigateTo(context, Routes.finish);
  }

  _showDatePicker() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.white,
              height: 300,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () => Application.router.pop(context),
                    child: const Text('DONE'),
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (d) {
                        _dob.text = '${d.year}-${d.month}-${d.day}';
                        setState(() {});
                      },
                      initialDateTime: DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(3000),
      ).then((d) {
        _dob.text = '${d!.year}-${d.month}-${d.day}';
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var an = Provider.of<AuthNotifier>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: 50,
                      width: 70,
                      child: Placeholder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Name',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (v) {
                          if (v!.isEmpty) return 'Field is empty';
                          return null;
                        },
                        onSaved: (v) => an.setDetails(UserMap.firstname, v),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Last Name',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (v) {
                          if (v!.isEmpty) return 'Field is empty';
                          return null;
                        },
                        onSaved: (v) => an.setDetails(UserMap.lastname, v),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: Gender.male,
                        groupValue: _gender,
                        onChanged: (Gender? value) {
                          setState(() => _gender = value!);
                        },
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      Text(
                        'Male',
                        style: TextStyle(color: _gray, fontSize: 19),
                      ),
                      const SizedBox(width: 10),
                      Radio(
                        value: Gender.female,
                        groupValue: _gender,
                        onChanged: (Gender? value) {
                          setState(() => _gender = value!);
                        },
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      Text(
                        'Female',
                        style: TextStyle(color: _gray, fontSize: 19),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (v) {
                          if (v!.isEmpty) return 'Field is empty';
                          if (!v.contains('@')) return 'Invalid email';
                          return null;
                        },
                        onSaved: (v) => an.setDetails(UserMap.email, v),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Phone number',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          shape: BoxShape.rectangle,
                        ),
                        child: InternationalPhoneNumberInput(
                          onSaved: (a) {
                            var p = a.phoneNumber!.substring(
                              a.dialCode!.length,
                            );

                            an.setDetails(UserMap.phone, p);
                          },
                          inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          onInputChanged: (a) {
                            var p = a.phoneNumber!.substring(
                              a.dialCode!.length,
                            );

                            an.setDetails(UserMap.phone, p);
                          },
                          spaceBetweenSelectorAndTextField: 0,
                        ),
                      ),
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        obscureText: _hidden,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidden = !_hidden;
                              });
                            },
                            icon: _hidden
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (v) {
                          if (v!.isEmpty) return 'Field is empty';
                          if (v.length < 6) return 'Password too short';
                          return null;
                        },
                        onSaved: (v) => an.setDetails(UserMap.password, v),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Date of birth',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        readOnly: true,
                        controller: _dob,
                        onTap: () => _showDatePicker(),
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (v) {
                          if (v!.isEmpty) return 'Field is empty';
                          return null;
                        },
                        onSaved: (v) => an.setDetails(UserMap.datebirth, v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () => _next(),
                    child: Text(
                      'NEXT',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      GestureDetector(
                        onTap: () => Application.router.navigateTo(
                          context,
                          Routes.login,
                        ),
                        child: Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
