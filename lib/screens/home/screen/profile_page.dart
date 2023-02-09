import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rive_animation/screens/home/models/detail_user_model.dart';
import 'package:rive_animation/screens/home/screen/change_password_screen.dart';
import 'package:rive_animation/screens/home/service/detail_user_service.dart';
import 'package:rive_animation/screens/home/service/storge_service.dart';
import '../../../main.dart';
import '../../auth/service/auth_service.dart';
import '../utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  MaskTextInputFormatter emailValidator = MaskTextInputFormatter(
      mask: "##########################@gmail.com",
      filter: {"#": RegExp(r'[a-z]')},
      type: MaskAutoCompletionType.lazy);

  MaskTextInputFormatter dateValidator =
      MaskTextInputFormatter(mask: "####-##-##");

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final components = value.split("-");
    if (components.length == 3) {
      final day = int.tryParse(components[2]);
      final month = int.tryParse(components[1]);
      final year = int.tryParse(components[0]);
      if (day != null && month != null && year != null) {
        final date = DateTime(year, month, day);
        if (date.year == year && date.month == month && date.day == day) {
          return null;
        }
      }
    }
    return "wrong date";
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  User? user;
  Future<List<DetailUserModel>>? detailUserModels;
  List<DetailUserModel>? detailUserModels_normal;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    user = FirebaseAuth.instance.currentUser!;

    detailUserModels = DetailUserService.Read();
    detailUserModels_normal = await DetailUserService.Read();
//final DateFormat formatter = DateFormat('yyyy-MM-dd');
    setState(() {
      emailController.text = user?.email! as String;
      birthController.text =
          detailUserModels_normal![0].birthDay.toString().substring(0, 10);
      addressController.text = detailUserModels_normal![0].address.toString();
      phoneController.text = detailUserModels_normal![0].phoneNumber.toString();
      genderController.text = detailUserModels_normal![0].gender.toString();
    });
  }

  void upload_image() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bạn chưa chọn file'),
        ),
      );
      return;
    }

    final path = result.files.single.path!;
    final fileName = result.files.single.name;

    print(path);
    print(fileName);

    StorageService.uploadFile(path, fileName).then((value) async {
      String location = 'gs://ezi2learn-badad.appspot.com/profile/$fileName';
      final gsReference =
          await FirebaseStorage.instance.refFromURL(location).getDownloadURL();

      print(gsReference);

      setState(() {
        detailUserModels_normal?[0].avatarUrl = gsReference;
      });
    });
  }

  bool isEdditing = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(414, 896));

    Widget groupTextField = Column(
      children: [
        Text(
          emailController.text,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            inputFormatters: [dateValidator],
            validator: validateDate,
            autocorrect: false,
            autovalidateMode: AutovalidateMode.always,
            controller: birthController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            onChanged: (str) {
              setState(() {
                setState(() {
                  isEdditing = true;
                });
              });
            },
            decoration: InputDecoration(
                //prefixText: "text ",
                prefixIcon: Container(
                  width: 110,
                  padding: EdgeInsets.fromLTRB(20, 14, 30, 0),
                  child: Text(
                    'BirthDay',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 20, 0),
                  child: CustomCard(
                    borderRadius: 100,
                    child: Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                hintText: 'BirthDay',
                border: InputBorder.none),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            onChanged: (str) {
              setState(() {
                setState(() {
                  isEdditing = true;
                });
              });
            },
            controller: addressController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                prefixIcon: Container(
                  width: 110,
                  padding: EdgeInsets.fromLTRB(20, 14, 30, 0),
                  child: Text(
                    'Address',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 20, 0),
                  child: CustomCard(
                    borderRadius: 100,
                    child: Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                hintText: 'Address',
                border: InputBorder.none),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            onChanged: (str) {
              setState(() {
                setState(() {
                  isEdditing = true;
                });
              });
            },
            controller: phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            maxLength: 10,
            decoration: InputDecoration(
                prefixIcon: Container(
                  width: 110,
                  padding: EdgeInsets.fromLTRB(20, 14, 30, 0),
                  child: Text(
                    'Phone number',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 20, 0),
                  child: CustomCard(
                    borderRadius: 100,
                    child: Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                hintText: 'Phone number',
                border: InputBorder.none),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            onChanged: (str) {
              setState(() {
                setState(() {
                  isEdditing = true;
                });
              });
            },
            controller: genderController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                prefixIcon: Container(
                  width: 110,
                  padding: EdgeInsets.fromLTRB(20, 14, 30, 0),
                  child: Text(
                    'Gender',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 20, 0),
                  child: CustomCard(
                    borderRadius: 100,
                    child: Icon(
                      Icons.edit,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                hintText: 'Gender',
                border: InputBorder.none),
          ),
        ),
      ],
    );

    Widget pageBody = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // SizedBox(
              //   height: 140,
              //   width: 140,
              //   child: Stack(
              //     children: <Widget>[
              //       CircleAvatar(
              //           radius: 140,
              //           backgroundImage: NetworkImage(
              //             (detailUserModels_normal?[0].avatarUrl == '')
              //                 ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
              //                 : detailUserModels_normal?[0].avatarUrl ?? '',
              //           )),
              //       Align(
              //         alignment: Alignment.bottomRight,
              //         child: InkWell(
              //           onTap: () async {},
              //           child: Container(
              //             height: 40,
              //             width: 40,
              //             decoration: const BoxDecoration(
              //               color: Colors.yellow,
              //               shape: BoxShape.circle,
              //             ),
              //             child: const Center(
              //               heightFactor: 30,
              //               widthFactor: 30,
              //               child: Icon(
              //                 LineAwesomeIcons.pen,
              //                 color: Colors.black,
              //                 size: 25,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // Text(
              //   'My Profile',
              //   style: TextStyle(
              //     fontWeight: FontWeight.w700,
              //     fontSize: 24,
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),

              CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    (detailUserModels_normal?[0].avatarUrl == '')
                        ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                        : detailUserModels_normal?[0].avatarUrl ?? '',
                  )),

              const SizedBox(height: 10),

              CustomCard(
                childPadding: 24,
                borderRadius: 12,
                color: Color(0xffdbf9f8),
                child: groupTextField,
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                  visible: isLoading,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )),
              Visibility(
                visible: isLoading ? false : true,
                child: ElevatedButton(
                  onPressed: () async {
                    if (isEdditing) {
                      if (_formKey.currentState!.validate()) {
                        String dateString = birthController.text;
                        print(dateString);
                        final components = dateString.split("-");
                        if (components.length == 3) {
                          final day = int.tryParse(components[2]);
                          final month = int.tryParse(components[1]);
                          final year = int.tryParse(components[0]);
                          print(
                              "kiet ${components[2]} ${components[1]}  ${components[0]} ");
                          if (day != null && month != null && year != null) {
                            final date = DateTime(year, month, day);
                            detailUserModels_normal?[0].birthDay = date;
                            print(date);
                          }
                        }
                        detailUserModels_normal?[0].address =
                            addressController.text;
                        detailUserModels_normal?[0].gender =
                            genderController.text;
                        detailUserModels_normal?[0].phoneNumber =
                            phoneController.text;

                        print(detailUserModels_normal?[0].toJson());
                        setState(() {
                          isLoading = true;
                        });
                        await DetailUserService.Update(
                            detailUserModels_normal?[0]);

                        setState(() {
                          isEdditing = false;
                          isLoading = false;
                        });
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const MainPage()));
                        // navigatorKey.currentState!
                        //     .popUntil((route) => route.isFirst);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cập nhật thành công'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Thông tin đã điền lổi')),
                        );
                      }
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePassWordScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffffe482),
                      shape: const StadiumBorder(),
                      minimumSize: Size(
                        MediaQuery.of(context).size.width - 40,
                        50,
                      )),
                  child: Text(
                    isEdditing ? 'Save' : 'Change Password',
                    style: TextStyle(
                      color: Color.fromARGB(255, 87, 87, 87),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  await AuthService.LogOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffffe482),
                    shape: const StadiumBorder(),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width - 40,
                      50,
                    )),
                child: Text('Log out'),
              ),
            ],
          ),
        ),
      ),
    );

    return FutureBuilder(
        future: detailUserModels,
        builder: (BuildContext context,
            AsyncSnapshot<List<DetailUserModel>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return pageBody;
          } else if (snapshot.connectionState == ConnectionState.done &&
              detailUserModels_normal!.isEmpty) {
            return Center(
              child: ListView(
                children: const <Widget>[
                  Align(
                      alignment: AlignmentDirectional.center,
                      child: Text('No data available')),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
