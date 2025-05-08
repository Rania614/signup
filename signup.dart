import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart'; // أضفنا المكتبة هنا
import 'package:form_builder_validators/form_builder_validators.dart'; // أضفنا المكتبة هنا

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>(); // غيرنا نوع المفتاح لـ FormBuilderState
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6D2A8A),
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder( // استبدلنا Form بـ FormBuilder
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              FormBuilderTextField( // استبدلنا TextFormField بـ FormBuilderTextField
                name: 'email', // أضفنا اسم للحقل عشان نستخدمه في الفالديشن
                decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                validator: FormBuilderValidators.compose([ // استخدمنا FormBuilderValidators
                  FormBuilderValidators.required(errorText: 'Please enter your email'),
                  FormBuilderValidators.email(errorText: 'Invalid email'),
                ]),
                onChanged: (value) => _email = value ?? '',
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                name: 'password',
                decoration: InputDecoration(labelText: 'password', border: OutlineInputBorder()),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Please enter your password'),
                  FormBuilderValidators.minLength(6, errorText: 'Password must be at least 6 characters'),
                ]),
                onChanged: (value) => _password = value ?? '',
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging in with $_email')));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), minimumSize: Size(double.infinity, 50)),
                child: Text('LOGIN', style: TextStyle(fontSize: 18)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text("Don't have an account? Register Now", style: TextStyle(color: Color(0xFF6D2A8A))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormBuilderState>(); 
  String _email = '';
  String _name = '';
  String _mobile = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Signup Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder( 
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign up Form', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              FormBuilderTextField(
                name: 'email',
                decoration: InputDecoration(labelText: 'Email Here', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Please enter your email'),
                  FormBuilderValidators.email(errorText: 'Invalid email'),
                ]),
                onChanged: (value) => _email = value ?? '',
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                name: 'name',
                decoration: InputDecoration(labelText: 'Name Here', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                validator: FormBuilderValidators.required(errorText: 'Please enter your name'),
                onChanged: (value) => _name = value ?? '',
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                name: 'mobile',
                decoration: InputDecoration(labelText: 'Mobile Here', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                keyboardType: TextInputType.phone,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Please enter your mobile'),
                  FormBuilderValidators.numeric(errorText: 'Must be numbers'),
                  FormBuilderValidators.minLength(10, errorText: 'Must be 10 digits'),
                  FormBuilderValidators.maxLength(10, errorText: 'Must be 10 digits'),
                ]),
                onChanged: (value) => _mobile = value ?? '',
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                name: 'password',
                decoration: InputDecoration(labelText: 'Password Here', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Please enter your password'),
                  FormBuilderValidators.minLength(6, errorText: 'Password must be at least 6 characters'),
                ]),
                onChanged: (value) => _password = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signing up with $_email')));
                    Navigator.pushNamed(context, '/login');
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), minimumSize: Size(double.infinity, 50)),
                child: Text('Submit', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}