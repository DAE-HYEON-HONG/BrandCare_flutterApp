import 'package:brandcare_mobile_flutter_v2/controllers/auth/find_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/findAccount/find_id_component.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/findAccount/find_pw_component.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPWPage extends GetView<FindController> {
  const FindPWPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(title: '비밀번호 찾기',
        child: SafeArea(
            child: Column(
              children: [
                // DefaultTabController(
                //   length: 2,
                //   child: Column(
                //     children: [
                //
                //     ],
                //   ),
                // ),
                const SizedBox(height: 20,),
                //
                Flexible(
                  child:  FindPwComponent(),
                ),
              ],
            )
        ));
  }
}
