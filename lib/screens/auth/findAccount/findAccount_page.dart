import 'package:brandcare_mobile_flutter_v2/controllers/auth/find_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/findAccount/find_id_component.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/findAccount/find_pw_component.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindAccountPage extends GetView<FindController> {
  const FindAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(title: '아이디/비밀번호 찾기',
        child: SafeArea(
          child: Column(
            children: [
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 48,
                      child: TabBar(
                          controller: controller.tabController,
                          tabs: [
                            Tab(
                              text: '아이디 찾기',
                            ),
                            Tab(
                                text: '비밀번호 찾기'
                            )
                          ]),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      FindIdComponent(),
                      FindPwComponent()
                    ]),
              ),
            ],
          )
        ));
  }
}
