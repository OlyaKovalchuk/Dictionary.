import 'package:flutter/cupertino.dart';

 errorView() {
  try{
    return Center(
      child: Text('Error'),
    );
  }catch(e){
    print(e);
  }

}
