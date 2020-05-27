import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:liquid_engine/liquid_engine.dart';
import 'package:nivo/models/Dish.dart';
import 'package:path_provider/path_provider.dart';

class CheckBtn extends StatelessWidget {
  static const String _template = '''
  <html>
  <title>Order ID: {{id}}</title>
  <body>
    <table>
      <thead>
        <th>Название</th>
        <th>Цена</th>
      </thead>
      <tbody>
      {% for dish in dishes %}
        <tr>
          <td>{{dish.name}}</td>
          <td>{{dish.price}}</td>
        </tr>
      {% endfor %}
      </tbody>
    </table>
    <div>Cумма: {{totalPrice}}</div>
  </body>
  </html>
  ''';
  final String order;
  List<IDDish> _dishes;

  CheckBtn({List<IDDish> dishes, this.order})
      : _dishes = dishes != null ? dishes : [];

  Future<String> createCheck() async {
    final context = Context.create();
    context.variables['id'] = order;
    context.variables['totalPrice'] = _dishes
        .map((e) => double.parse(e.getPrice().split(" ")[0]))
        .reduce((value, element) => value + element);
    context.variables['dishes'] =
        _dishes.map((e) => {'name': e.getName(), 'price': e.getPrice()});
    final document = Template.parse(context, Source.fromString(_template));
    print(document.render(context));

    Directory appDocDir = await getExternalStorageDirectory();
    var targetPath = appDocDir.path;
    var targetFileName = order;

    File generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        document.render(context), targetPath, targetFileName);
    return generatedPdfFile.path;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: Icon(
          Icons.markunread,
          color: Colors.white,
        ),
        onPressed: () {
          createCheck().then((value) => print(value));
        });
  }
}
