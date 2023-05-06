import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usersapp/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  final void Function() _toggleTheme;
  const LoginScreen(this._toggleTheme, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseFirestore.instance.collection('users').add(_formData);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  final _formData = {
    'name': '',
    'email': '',
    'source': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: widget._toggleTheme, icon: const Icon(Icons.dark_mode))
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 80),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Users App\nLogo',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(fontSize: 40),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  onSaved: (value) {
                    _formData['name'] = value!;
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: const Text('Enter your Name'),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Atleast 3 characters required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _formData['email'] = value!;
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      label: const Text('Enter your Email'),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (!value!.contains('@') || value.isEmpty) {
                        return "Please enter a valid email";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  onChanged: (_) {},
                  onSaved: (value) {
                    _formData['source'] = value!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please choose a category';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.sailing_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: const Text('Where are you coming from'),
                    border: const OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Facebook',
                      child: Text('Facebook'),
                    ),
                    DropdownMenuItem(
                      value: 'Instagram',
                      child: Text('Instagram'),
                    ),
                    DropdownMenuItem(
                      value: 'Organic',
                      child: Text('Organic'),
                    ),
                    DropdownMenuItem(
                      value: 'Friend',
                      child: Text('Friend'),
                    ),
                    DropdownMenuItem(
                      value: 'Google',
                      child: Text('Google'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 6),
                  onPressed: _submit,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: _isLoading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator()),
                          )
                        : const Text(
                            'Go Ahead!',
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
