import 'package:flutter/material.dart';
import 'package:kexze_logistics/config/routes/route.dart';
import 'package:kexze_logistics/config/routes/route_config.dart';
import 'package:kexze_logistics/core/assets/assets.dart';
import 'package:kexze_logistics/features/authentication/data/model/user.dart';
import 'package:kexze_logistics/features/authentication/presentation/change-notifier/auth_notifier.dart';
import 'package:provider/provider.dart';

import '../widgets/links.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _form = GlobalKey();
  final Color _gray = const Color.fromRGBO(79, 79, 79, 1);
  var _isLoading = false;

  void _login() {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    setState(() => _isLoading = !_isLoading);

    Provider.of<AuthNotifier>(context, listen: false).login().then((value) {
      value.fold(
        (l) => l,
        (r) => Application.router.navigateTo(
          context,
          Routes.dashboard,
          clearStack: true,
        ),
      );

      setState(() => _isLoading = !_isLoading);
    });
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(kLOGO, height: 60),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Login To Your Rider Account',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 30),
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
                          if (v!.isEmpty) return 'Email address is empty';
                          if (!v.contains('@')) {
                            return 'Please use a valid email';
                          }
                          return null;
                        },
                        onSaved: (v) => an.setDetails(UserMap.email, v),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Password',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (v) {
                          if (v!.isEmpty) return 'Password is empty';
                          return null;
                        },
                        onSaved: (v) => an.setDetails(UserMap.password, v),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: _isLoading ? null : () {},
                            child: const Text('Forgot Password'),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _isLoading ? null : () => _login(),
                    child: Text(
                      'LOGIN',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New to Kaxze'),
                      const SizedBox(width: 13),
                      GestureDetector(
                        onTap: _isLoading
                            ? null
                            : () => Application.router.navigateTo(
                                  context,
                                  Routes.create,
                                ),
                        child: const Text(
                          'CREATE AN ACCOUNT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container(color: _gray, height: 1)),
                      const SizedBox(width: 10),
                      const Text('OR'),
                      const SizedBox(width: 10),
                      Expanded(child: Container(color: _gray, height: 1)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Links(
                    label: 'Continue with Facebook',
                    linkIcons: kFACEBOOK,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  const Links(
                    label: 'Continue with Google   ',
                    linkIcons: kGOOGLE,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
