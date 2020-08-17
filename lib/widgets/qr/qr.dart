import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncckios/base/color.dart';
import 'package:ncckios/widgets/qr/qr_bloc.dart';
import 'package:ncckios/widgets/shortcut/shortcut.dart';
import 'package:qr_flutter/qr_flutter.dart';
class QR extends StatefulWidget {
  const QR({Key key, this.orderId}) : super(key: key);
  final int orderId;


  @override
  _QRState createState() => _QRState();
}

class _QRState extends State<QR> {

  QrBloc bloc=QrBloc();
  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
  @override
  void initState() {
//    bloc = BlocProvider.of(context);
    bloc.add(QREventCreateQrOrder(widget.orderId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
//    double width = MediaQuery.of(context).size.width;
    print('This is size${MediaQuery.of(context).size}');
    return BlocBuilder<QrBloc,QrState>(
      cubit: bloc,
      builder: (BuildContext context,QrState state){
        if(state is QrStateLoading){
          return loading(context);
        }
        else if (state is QrStateShowData){
          return Center(
            child: QrImage(
              data: state.data,
              backgroundColor: AppColor.white,
              version: QrVersions.auto,
              size: 200 *height/683.4,
              gapless: false,
            ),
          );
        }
        else if(state is QrStateFail){
          return  RaisedButton(
            color: AppColor.white,
            onPressed: (){
              bloc.add(QREventCreateQrOrder(widget.orderId));
            },
            child: const Text('Xin thử lại!'),
          );
        }

        return const Material();
      },
    );
  }


}
