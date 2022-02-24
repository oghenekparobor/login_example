import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:shake_widget/controller.dart';
import 'package:shake_widget/shake_widget.dart';

import '../../../../config/routes/route.dart';
import '../../../../config/routes/route_config.dart';
import '../../../../core/assets/assets.dart';
import '../../data/model/user.dart';
import '../change-notifier/auth_notifier.dart';

enum Gender { male, female }

class FinishAccount extends StatefulWidget {
  const FinishAccount({Key? key}) : super(key: key);

  @override
  State<FinishAccount> createState() => _FinishAccountState();
}

// add controllers for validation
class _FinishAccountState extends State<FinishAccount> {
  final GlobalKey<FormState> _form = GlobalKey();
  late ShakeController _disclaimer;
  late ShakeController _passport;
  bool _agree = false;

  late TextEditingController _state;
  late ImagePicker _picker;

  @override
  void initState() {
    _state = TextEditingController();
    _disclaimer = ShakeController();
    _passport = ShakeController();
    _picker = ImagePicker();

    super.initState();
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  void _submit() {
    var an = Provider.of<AuthNotifier>(context, listen: false);

    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    if (an.details[UserMap.passport].isEmpty) {
      _passport.shake();
    } else {
      if (!_agree) {
        _disclaimer.shake();
      } else {
        an.createAccount().then((value) {
          value.fold(
            (l) => l,
            (r) => Application.router.navigateTo(
              context,
              Routes.dashboard,
              clearStack: true,
            ),
          );
        });
      }
    }
  }

  void _showPopupMenu(AuthNotifier an) async {
    await showMenu(
        elevation: 8.0,
        context: context,
        position: const RelativeRect.fromLTRB(100, 200, 0, 100),
        items: an.states
            .map(
              (e) => PopupMenuItem(
                child: Text(e.name),
                onTap: () {
                  an.setDetails(
                    UserMap.stateorigin,
                    e.name,
                  );
                  _state.text = e.name;
                  setState(() {});
                },
              ),
            )
            .toList());
  }

  _showPicker(AuthNotifier an) async {
    await _picker
        .pickImage(
            source: ImageSource.camera,
            imageQuality: 30,
            preferredCameraDevice: CameraDevice.rear)
        .then((value) {
      an.setDetails(UserMap.passport, value!.path);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var an = Provider.of<AuthNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
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
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address',
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
                        onSaved: (v) => an.setDetails(UserMap.address, v),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'State of Origin',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 5),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (Widget c, Animation<double> a) =>
                            ScaleTransition(scale: a, child: c),
                        child: FutureBuilder(
                          future: an.getStates(),
                          builder: (_, s) {
                            if (s.connectionState == ConnectionState.none) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Consumer<AuthNotifier>(
                                builder: (_, value, __) => TextFormField(
                                  controller: _state,
                                  readOnly: true,
                                  onTap: () => _showPopupMenu(an),
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    constraints: const BoxConstraints(
                                      maxHeight: 55,
                                      maxWidth: 368,
                                    ),
                                    suffixIcon: PopupMenuButton(
                                      itemBuilder: (context) => value.states
                                          .map(
                                            (e) => PopupMenuItem(
                                              child: Text(e.name),
                                              onTap: () {
                                                an.setDetails(
                                                  UserMap.stateorigin,
                                                  e.name,
                                                );
                                                _state.text = e.name;
                                                setState(() {});
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  validator: (v) {
                                    if (v!.isEmpty) return 'Field is empty';
                                    return null;
                                  },
                                  onSaved: (v) =>
                                      an.setDetails(UserMap.stateorigin, v),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'LGA',
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
                        onSaved: (v) => an.setDetails(UserMap.lga, v),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () => _showPicker(an),
                        child: Consumer<AuthNotifier>(
                          builder: (context, value, child) => ShakeWidget(
                            shakeController: _passport,
                            vibrate: true,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    child: ImageIcon(
                                      const AssetImage(kSCAN),
                                      color: value.details[UserMap.passport]
                                              .toString()
                                              .isEmpty
                                          ? Colors.grey
                                          : Colors.green,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Checkbox(
                                  value: value.details[UserMap.passport]
                                      .toString()
                                      .isNotEmpty,
                                  onChanged: (_) {},
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'NIN',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      constraints: const BoxConstraints(
                        maxHeight: 55,
                        maxWidth: 368,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) return 'Field is empty';
                      return null;
                    },
                    onSaved: (v) => an.setDetails(UserMap.nin, v),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Next of Kin',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      constraints: const BoxConstraints(
                        maxHeight: 55,
                        maxWidth: 368,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) return 'Field is empty';
                      return null;
                    },
                    onSaved: (v) => an.setDetails(UserMap.kinname, v),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Next of Kin address',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      constraints: const BoxConstraints(
                        maxHeight: 55,
                        maxWidth: 368,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) return 'Field is empty';
                      return null;
                    },
                    onSaved: (v) => an.setDetails(UserMap.kinaddress, v),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Next of kin phone',
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

                        an.setDetails(UserMap.kinphone, p);
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

                        an.setDetails(UserMap.kinphone, p);
                      },
                      spaceBetweenSelectorAndTextField: 0,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Disclamer',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 5),
                  ShakeWidget(
                    shakeController: _disclaimer,
                    vibrate: true,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _agree,
                            onChanged: (_) => setState(() => _agree = !_agree),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'I hereby agree that all informations provided are correct and truthful,i agree to be held accountable if any appears to be false.',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () => _submit(),
                    child: Text(
                      'SUBMIT',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white),
                    ),
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
