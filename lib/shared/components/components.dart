import 'package:flutter/material.dart';
import 'package:newsapp/modules/news_app/web_view/web_view_screen.dart';

Widget defaultTextButton({
  required String text,
  required Function() function,
  Color? color,
  double? size,
  FontWeight? fontWeight,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase(),
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: fontWeight,
          )),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  required Function() function,
  required String text,
}) =>
    Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFromField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  Function()? onTap,
  required String? Function(String?)? validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      obscureText: isPassword,
      validator: validate,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      enabled: isClickable,
      onChanged: onChange,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget buildArticleItem(
  dynamic article,
  context,
) =>
    InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(url: article['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: article['urlToImage'] != null
                      ? NetworkImage('${article['urlToImage']}')
                      : const NetworkImage(
                          'https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
Widget articleBuilder(List<dynamic> list, context, {isSearch = false}) {
  if (list.isEmpty) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.deepOrange,
      ),
    );
  } else {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: list.length,
    );
  }
}

Widget articleBuilderSearch(List<dynamic> list, context, {isSearch = false}) {
  if (isSearch == true) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.deepOrange,
      ),
    );
  } else {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: list.length,
    );
  }
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
