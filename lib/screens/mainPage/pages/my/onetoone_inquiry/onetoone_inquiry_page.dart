import 'package:brandcare_mobile_flutter_v2/controllers/my/inquiry_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/onetoone_inquiry/inquiry_list_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/onetoone_inquiry/inquiry_page.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OneToOneInquiryPage extends GetView<InquiryController> {
  const OneToOneInquiryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: '1:1 문의',
      child: Column(
        children: [
          const SizedBox(height: 40,),
          SizedBox(
            height: 48,
            child: TabBar(
                controller: controller.tabController,
                tabs: [
                  Tab(
                    text: '문의사항 입력',
                  ),
                  Tab(
                      text: '문의내역 확인'
                  )
                ]),
          ),
          Flexible(
            child: TabBarView(
                controller: controller.tabController,
                children: [
                  InquiryPage(),
                  InquiryListPage()
                ]),
          ),
        ],
      ),
    );
  }
}

