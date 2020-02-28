import 'dart:io';
import 'dart:convert';
import 'package:xml/xml.dart' as xml; //XML lib for all the XML related task


void main() async {
  var request = await HttpClient().getUrl(Uri.parse('https://raw.githubusercontent.com/spdx/license-list-XML/master/src/MIT.xml'));
  var response = await request.close(); 
  String fullString;
  fullString = "";
  await for (var contents in response.transform(Utf8Decoder())) {
    fullString += contents;
  }
  var xmlString = xml.parse(fullString);

//This block will print all the attributes in the XML file
  var attribute = xmlString.descendants;
  for (var list_attribute in attribute) {
    var single_attribute = list_attribute.attributes;
    for(var item in single_attribute)
    {
      print(item);
    }
  }

//=============================================
print('\n');
//=============================================

//this block will print all the textual data of the XML file

var final_text = "";
 var textual = xmlString.descendants;
 for(var list in textual)
 {
   if(list is xml.XmlText && !list.text.trim().isEmpty)
   {
     final_text += "\n" + list.text.toString();
   }
 }
 print(final_text);
}