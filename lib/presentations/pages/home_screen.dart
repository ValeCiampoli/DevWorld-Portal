import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:portal/commons/theme.dart';
import 'package:portal/data/models/memo_model.dart';
import 'package:portal/data/models/user_model.dart';
import 'package:portal/presentations/state_management/auth_provider.dart';
import 'package:portal/presentations/state_management/memo_provider.dart';
import 'package:portal/presentations/widgets/home_widget/showcase_widget.dart';
import 'package:portal/presentations/widgets/other_widgets/memo.dart';
import 'package:portal/presentations/widgets/other_widgets/memo_painter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double top = 0;
  double left = 0;
  List<MemoModel> memoModel = [];

  bool isRaccomended = true;
  bool showloader = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<MemoListProvider>().getAllMemo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context).currentUser;
    return Material(
      child: ResponsiveBuilder(builder: (context, size) {
        return Consumer<MemoListProvider>(
            builder: (context, memoProvider, child) {
          return memoProvider.memoList == null
              ? SizedBox(
                  width: size.deviceScreenType == DeviceScreenType.mobile
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width - 60,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                      child: LoadingAnimationWidget.beat(
                    color: const Color.fromARGB(255, 255, 177, 59),
                    size: 60,
                  )),
                )
              : size.deviceScreenType == DeviceScreenType.mobile
                  ? Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30.0, bottom: 10),
                            child: Text(
                              'Appuntamenti',
                              style: DWTextTypography.of(context).text18bold.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Showcase(
                            width: MediaQuery.of(context).size.width,
                          ),
                          SizedBox(
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: memoProvider.memoList!.length,
                              itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Memo(memo: memoProvider.memoList![index]),
                              );
                            },),
                          )
                        ],
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Bacheca',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    )
                                  ],
                                ),
                              ),
                              Stack(children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(13)),
                                    color: Color.fromARGB(255, 234, 234, 234),
                                  ),
                                  width: MediaQuery.of(context).size.width - 60,
                                  height: 500,
                                  child: Stack(
                                    children: [
                                      for (var i in memoProvider.memoList!)
                                        Positioned(
                                          top: i.top,
                                          left: i.left,
                                          child: Draggable(
                                              onDragUpdate: (details) {
                                                top = details.delta.dy;
                                                left = details.delta.dx;
                                              },
                                              onDragEnd: (details) async {
                                                setState(() {
                                                  top = details.offset.dy;
                                                  left = details.offset.dx;
                                                  i.top = top;
                                                  i.left = left;
                                                  print(top);
                                                });
                                                await context
                                                    .read<MemoListProvider>()
                                                    .storeNewPosition(MemoModel(
                                                        top: top,
                                                        left: left,
                                                        userId: i.userId,
                                                        id: i.id,
                                                        body: i.body));
                                              },
                                              feedback: Memo(
                                                memo: i,
                                              ),
                                              child: Memo(memo: i)),
                                        )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 60,
                                  height: 500,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await showCreateMemo(user);
                                        },
                                        child: const CircleAvatar(
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                              const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Comunicazioni',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Showcase(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                  ),
                                  //  Showcase(),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
        });
      }),
    );
  }

  Future<void> showCreateMemo(UserModel user) async {
    TextEditingController memoController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: 500,
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'lib/resources/images/devworld.png',
                    width: 200,
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Stack(
                        children: [
                          CustomPaint(
                            size: Size(
                                200,
                                (200 * 1.0516378413201843)
                                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            painter: RPSCustomPainter(),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: SizedBox(
                                width: 170,
                                height: 170,
                                child: TextField(
                                  controller: memoController,
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 7,
                                  decoration: const InputDecoration(
                                      isDense: false, border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0, top: 25),
                  child: SizedBox(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await context.read<MemoListProvider>().publishMemo(
                                body: memoController.text, userId: user.uid);
                            await context.read<MemoListProvider>().getAllMemo();
                            if (mounted) {
                              AutoRouter.of(context).pop();
                            }
                          },
                          child: Container(
                            width: 130,
                            height: 35,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                color: Colors.blue),
                            child: const SizedBox(
                              height: 200,
                              width: 100,
                              child: Center(
                                  child: Text(
                                'Salva',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
