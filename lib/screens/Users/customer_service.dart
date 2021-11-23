import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
// import 'package:nuthoop/widget/chatDetailPage.dart';

class CustomerService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBrandColor,
          title: Text('Consumer Service'),
          // actions: [
          //   Center(
          //       child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text('Request A call'),
          //   ))
          // ],
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: Tawk(
            directChatLink:
                'https://tawk.to/chat/60ee2b24d6e7610a49ab23e0/1fah5h2rj',
            // 'https://tawk.to/chat/60d9b6277f4b000ac039eccd/1f996v3pv',
            visitor: TawkVisitor(
              name: 'Admin',
              email: 'mine4christ@gmail.com',
            ),
            onLoad: () {
              print('Hello Tawk!');
            },
            onLinkTap: (String url) {
              print('this is url $url');
            },
            placeholder: Center(
              child: Text('Loading...'),
            ),
          ),

          // ChatDetailPage(),
        ),
      ),
    );
  }
}

// <!--Start of Tawk.to Script-->
// <script type="text/javascript">
// var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
// (function(){
// var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
// s1.async=true;
// s1.src='https://embed.tawk.to/610e75f2649e0a0a5cd0016a/1fcg7pfj8';
// s1.charset='UTF-8';
// s1.setAttribute('crossorigin','*');
// s0.parentNode.insertBefore(s1,s0);
// })();
// </script>
// <!--End of Tawk.to Script-->

// <!--Start of Tawk.to Script-->
// <script type="text/javascript">
// var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
// (function(){
// var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
// s1.async=true;
// s1.src='https://embed.tawk.to/60d9b6277f4b000ac039eccd/1f996v3pv';
// s1.charset='UTF-8';
// s1.setAttribute('crossorigin','*');
// s0.parentNode.insertBefore(s1,s0);
// })();
// </script>
// <!--End of Tawk.to Script-->
