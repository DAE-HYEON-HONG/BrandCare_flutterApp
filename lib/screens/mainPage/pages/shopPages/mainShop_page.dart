import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/mainShop_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/mainPage_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/shopListPages/mainShopListAll_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/shopListPages/mainShopListInst_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/shopListPages/mainShopListMine_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainShopPage extends StatelessWidget{
  final MainShopController controller = Get.put(MainShopController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.focusNode.unfocus(),
      child: FocusScope(
        node: controller.focusNode,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: _appBar(),
            backgroundColor: Colors.white,
            body: _renderBody(),
          ),
        ),
      ),
    );
  }

  //앱바
  _appBar() {
    final mainPageCtrl = Get.find<MainPageController>();
    return AppBar(
      leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){},
          child: Container(),
      ),
      title: Text("SHOP", style: medium16TextStyle.copyWith(color: primaryColor)),
      titleSpacing: 0,
      centerTitle: true,
      titleTextStyle: medium16TextStyle.copyWith(color: primaryColor),
      backgroundColor: whiteColor,
      elevation: 4,
      shadowColor: blackColor.withOpacity(0.05),
      automaticallyImplyLeading: false,
      actions: [
        GestureDetector(
          onTap: (){
            mainPageCtrl.onItemTaped(5);
          },
          child: SvgPicture.asset('assets/icons/mainNotice.svg', height: 19,),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  _renderBody() {
    return NestedScrollView(
      controller: controller.scrollViewCtrl,
      headerSliverBuilder: (context, bool innerBoxIsScrolled){
        return <Widget>[
          SliverAppBar(
            backgroundColor: whiteColor,
            toolbarHeight: 0.0, //이게 타이틀 height 값임.
            forceElevated: innerBoxIsScrolled,
            elevation: 1.0,
            automaticallyImplyLeading: false,
            pinned: true, //bottom 고정
            snap: false, //위로 스크롤 시 다시 뜨게 함.
            floating: false, //계속 뜨게 함
            expandedHeight: 180, //최대 어디까지 늘어날 것인지에 대한 값
            flexibleSpace: FlexibleSpaceBar( //늘어난 공간에 집어넣을 위젯을 설정
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              background: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => Get.toNamed("/mainShop/addProduct"),
                      child: Container(
                        width: 72,
                        height: 24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: primaryColor, width: 1)
                        ),
                        child: Center(
                          child: Text(
                            "글쓰기",
                            style: regular12TextStyle.copyWith(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: Color.fromRGBO(0, 0, 0, 0.15),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                              controller: controller.searchWord,
                              style: regular12TextStyle.copyWith(color: gray_999Color),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "검색어를 입력하세요",
                                hintStyle: regular12TextStyle.copyWith(color: gray_999Color),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: InkWell(
                              onTap: () => controller.reqSearchWord(),
                              child: SvgPicture.asset(
                                "assets/icons/search.svg",
                                height: 30,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide:
                BorderSide(width: 3.0, color: primaryColor),
              ),
              controller: controller.tabCtrl,
              physics: NeverScrollableScrollPhysics(),
              unselectedLabelColor: Color(0xff999999),
              unselectedLabelStyle: regular14TextStyle.copyWith(color: gray_333Color),
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              labelStyle: regular14TextStyle,
              tabs: <Widget>[
                Tab(
                  child: _tabBarText("전체"),
                ),
                Tab(
                  child: _tabBarText("내제품"),
                ),
                Tab(
                  child: _tabBarText("관심리스트"),
                ),
              ],
            ),
          ),
        ];
      },
      body: _renderTabBarView(),
    );
  }

  _tabBarText(String title){
    return Center(
      child: Text(
        title,
        style: regular14TextStyle,
      ),
    );
  }

  _renderTabBarView() {
    return TabBarView(
      controller: controller.tabCtrl,
      children: [
        MainShopListAllPage(),
        MainShopListMinePage(),
        MainShopListInstPage(),
      ],
    );
  }
}
