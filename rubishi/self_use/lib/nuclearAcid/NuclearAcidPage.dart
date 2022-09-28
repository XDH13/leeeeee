import 'package:flutter/cupertino.dart';

class NuclearAcidPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => NuclearAcidPageState();
}
class NuclearAcidPageState extends State<NuclearAcidPage>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 360,
            minHeight: 800
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  "艾迪康"
                ),
              ),
              Image.asset("assets/png_pics/heima.png"),
              Center(
                child: Text(
                    "大筛"
                ),
              ),
              Image.asset("assets/png_pics/dashai.png")
            ],
          ),
        )
        ,
      ),
    );
  }

}