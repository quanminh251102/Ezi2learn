import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rive_animation/screens/auth/service/auth_service.dart';
import 'package:rive_animation/screens/home/models/detail_user_model.dart';
import 'package:rive_animation/screens/home/service/detail_user_service.dart';
import 'package:rive_animation/screens/home/service/storge_service.dart';
import '../../../main.dart';
import '../utils/constants.dart';

class ProfileScreen extends StatefulWidget {
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
    user = await FirebaseAuth.instance.currentUser!;

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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(414, 896));

    Widget pageBody = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 140,
                width: 140,
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                        radius: 140,
                        backgroundImage: NetworkImage(
                          (detailUserModels_normal?[0].avatarUrl == '')
                              ? 'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
                              : detailUserModels_normal?[0].avatarUrl ?? '',
                        )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () async {
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
                            return null;
                          }

                          final path = result.files.single.path!;
                          final fileName = result.files.single.name;

                          print(path);
                          print(fileName);

                          StorageService.uploadFile(path, fileName)
                              .then((value) async {
                            String location =
                                'gs://ezi2learn-badad.appspot.com/profile/$fileName';
                            final gsReference = await FirebaseStorage.instance
                                .refFromURL(location)
                                .getDownloadURL();

                            print(gsReference);

                            setState(() {
                              detailUserModels_normal?[0].avatarUrl =
                                  gsReference;
                            });
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            heightFactor: 30,
                            widthFactor: 30,
                            child: Icon(
                              LineAwesomeIcons.pen,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Nicolas Adams',
                style: kTitleTextStyle,
              ),
              SizedBox(height: 8),
              Text(
                emailController.text,
                style: kCaptionTextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Ngày sinh',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  inputFormatters: [dateValidator],
                  validator: validateDate,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                  controller: birthController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: 'Sinh nhật', border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Địa chỉ',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: 'Địa chỉ', border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Số điện thoại',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: 'Điện thoại', border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Giới tính',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: genderController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: 'Giới tính', border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     'Hủy',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.grey,
                  //       shape: StadiumBorder(),
                  //       minimumSize: Size(
                  //         150,
                  //         50,
                  //       )),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => Center(
                                  child: CircularProgressIndicator(),
                                ));
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
                        await DetailUserService.Update(
                            detailUserModels_normal?[0]);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()));
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
                    },
                    child: Text(
                      'Lưu',
                      style: TextStyle(
                        color: Color.fromARGB(255, 87, 87, 87),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFFDA2C),
                        shape: StadiumBorder(),
                        minimumSize: Size(
                          MediaQuery.of(context).size.width - 40,
                          50,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
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
          }),
    );
  }
}
