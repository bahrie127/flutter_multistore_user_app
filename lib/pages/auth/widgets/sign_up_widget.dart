import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic7_app/bloc/register/register_bloc.dart';
import 'package:flutter_fic7_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic7_app/data/models/request/register_request_model.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/custom_themes.dart';
import '../../../utils/dimensions.dart';
import '../../base_widgets/button/custom_button.dart';
import '../../base_widgets/text_field/custom_password_textfield.dart';
import '../../base_widgets/text_field/custom_textfield.dart';
import '../../dashboard/dashboard_page.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  SignUpWidgetState createState() => SignUpWidgetState();
}

class SignUpWidgetState extends State<SignUpWidget> {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  GlobalKey<FormState>? _formKey;

  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool isEmailVerified = false;

  addUser() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();
      final model = RegisterRequestModel(
        email: _emailController.text,
        password: _passwordController.text,
        name: _firstNameController.text,
      );
      context.read<RegisterBloc>().add(RegisterEvent.register(model));
      isEmailVerified = true;
    } else {
      isEmailVerified = false;
    }
  }

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      hintText: 'Name',
                      textInputType: TextInputType.name,
                      focusNode: _fNameFocus,
                      nextNode: _lNameFocus,
                      isPhoneNumber: false,
                      capitalization: TextCapitalization.words,
                      controller: _firstNameController,
                    )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault,
                    top: Dimensions.marginSizeSmall),
                child: CustomTextField(
                  hintText: 'Email',
                  focusNode: _emailFocus,
                  nextNode: _phoneFocus,
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault,
                    top: Dimensions.marginSizeSmall),
                child: CustomPasswordTextField(
                  hintTxt: 'Password',
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  nextNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault,
                    top: Dimensions.marginSizeSmall),
                child: CustomPasswordTextField(
                  hintTxt: 'Password Confirmation',
                  controller: _confirmPasswordController,
                  focusNode: _confirmPasswordFocus,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              left: Dimensions.marginSizeLarge,
              right: Dimensions.marginSizeLarge,
              bottom: Dimensions.marginSizeLarge,
              top: Dimensions.marginSizeLarge),
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  return ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                },
                loaded: (data) async {
                  await AuthLocalDatasource().saveAuthData(data);
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return DashboardPage();
                  }), (route) => false);
                },
              );
            },
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return CustomButton(onTap: addUser, buttonText: 'Sign Up');
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
        Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const DashboardPage();
                  }), (route) => false);
                },
                child: Text('Skip for Now',
                    style: titilliumRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: ColorResources.getPrimary(context)))),
            Icon(
              Icons.arrow_forward,
              size: 15,
              color: Theme.of(context).primaryColor,
            )
          ],
        )),
      ],
    );
  }
}
