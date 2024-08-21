import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uep/bloc/profile/profile_bloc.dart';
import 'package:uep/bloc/profile/profile_event.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/utils/validators.dart';
import 'package:uep/ui/screens/widgets/custom_text_field.dart';

class ProfilePage extends StatefulWidget {
  final UserModel userModel;
  const ProfilePage({
    super.key,
    required this.userModel,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.userModel.name);
    phoneController = TextEditingController(text: widget.userModel.phone);
    super.initState();
  }

  bool readOnly = true;

  void onTapSave() async {
    BlocProvider.of<ProfileBloc>(context).add(
      EditProfile(
        data: {
          "name": nameController.text,
          "phone": phoneController.text,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // double sreenWidth = MediaQuery.of(context).size.width;
    double sreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: readOnly
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FloatingActionButton(
                      heroTag: "save",
                      onPressed: onTapSave,
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FloatingActionButton(
                  heroTag: "settings",
                  backgroundColor: Colors.white,
                  onPressed: () {},
                  child: const Icon(
                    CupertinoIcons.settings,
                    size: 35,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: sreenHeight * 0.6,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffC4CBD6).withOpacity(0.1),
                    blurRadius: 58,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.teal,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              readOnly = !readOnly;
                            });
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/edit.svg",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      labelText: "Name",
                      hintText: "Your name",
                      controller: nameController,
                      readOnly: readOnly,
                      validator: Validator.validateName,
                    ),
                    const SizedBox(height: 25),
                    CustomTextField(
                      labelText: "Phone number",
                      hintText: "+998 88 118 05 15",
                      controller: phoneController,
                      readOnly: readOnly,
                      validator: Validator.validatePhoneNumber,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
