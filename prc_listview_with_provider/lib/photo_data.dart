
import 'package:flutter/cupertino.dart';

class PhotoData extends ChangeNotifier {

  static const json = [
    {'title':'TEST1', 'thumbnailUrl':'thumbnail1', 'id':1},
    {'title':'TEST2', 'thumbnailUrl':'thumbnail2', 'id':2},
    {'title':'TEST3', 'thumbnailUrl':'thumbnail3', 'id':3},
    {'title':'TEST4', 'thumbnailUrl':'thumbnail4', 'id':4},
    {'title':'TEST5', 'thumbnailUrl':'thumbnail5', 'id':5},
    {'title':'TEST6', 'thumbnailUrl':'thumbnail6', 'id':6},
    {'title':'TEST7', 'thumbnailUrl':'thumbnail7', 'id':7},
    {'title':'TEST8', 'thumbnailUrl':'thumbnail8', 'id':8},
    {'title':'TEST9', 'thumbnailUrl':'thumbnail9', 'id':9},
    {'title':'TEST10', 'thumbnailUrl':'thumbnail10', 'id':10},
    {'title':'TEST11', 'thumbnailUrl':'thumbnail11', 'id':11},
    {'title':'TEST12', 'thumbnailUrl':'thumbnail12', 'id':12},
    {'title':'TEST13', 'thumbnailUrl':'thumbnail13', 'id':13},
    {'title':'TEST14', 'thumbnailUrl':'thumbnail14', 'id':14},
    {'title':'TEST15', 'thumbnailUrl':'thumbnail15', 'id':15},
    {'title':'TEST16', 'thumbnailUrl':'thumbnail16', 'id':16},
    {'title':'TEST17', 'thumbnailUrl':'thumbnail17', 'id':17},
    {'title':'TEST18', 'thumbnailUrl':'thumbnail18', 'id':18},
    {'title':'TEST19', 'thumbnailUrl':'thumbnail19', 'id':19},
    {'title':'TEST20', 'thumbnailUrl':'thumbnail20', 'id':20},
    {'title':'TEST21', 'thumbnailUrl':'thumbnail21', 'id':21},
    {'title':'TEST22', 'thumbnailUrl':'thumbnail22', 'id':22},
    {'title':'TEST23', 'thumbnailUrl':'thumbnail23', 'id':23},
    {'title':'TEST24', 'thumbnailUrl':'thumbnail24', 'id':24},
    {'title':'TEST25', 'thumbnailUrl':'thumbnail25', 'id':25},
    {'title':'TEST26', 'thumbnailUrl':'thumbnail26', 'id':26},
    {'title':'TEST27', 'thumbnailUrl':'thumbnail27', 'id':27},
    {'title':'TEST28', 'thumbnailUrl':'thumbnail28', 'id':28},
    {'title':'TEST29', 'thumbnailUrl':'thumbnail29', 'id':29},
    {'title':'TEST30', 'thumbnailUrl':'thumbnail30', 'id':30},
    {'title':'TEST31', 'thumbnailUrl':'thumbnail31', 'id':31},
    {'title':'TEST32', 'thumbnailUrl':'thumbnail32', 'id':32},
    {'title':'TEST33', 'thumbnailUrl':'thumbnail33', 'id':33},
    {'title':'TEST34', 'thumbnailUrl':'thumbnail34', 'id':34},
    {'title':'TEST35', 'thumbnailUrl':'thumbnail35', 'id':35},
    {'title':'TEST36', 'thumbnailUrl':'thumbnail36', 'id':36},
    {'title':'TEST37', 'thumbnailUrl':'thumbnail37', 'id':37},
    {'title':'TEST38', 'thumbnailUrl':'thumbnail38', 'id':38},
    {'title':'TEST39', 'thumbnailUrl':'thumbnail39', 'id':39},
    {'title':'TEST40', 'thumbnailUrl':'thumbnail40', 'id':40},
    {'title':'TEST41', 'thumbnailUrl':'thumbnail41', 'id':41},
    {'title':'TEST42', 'thumbnailUrl':'thumbnail42', 'id':42},
    {'title':'TEST43', 'thumbnailUrl':'thumbnail43', 'id':43},
    {'title':'TEST44', 'thumbnailUrl':'thumbnail44', 'id':44},
    {'title':'TEST45', 'thumbnailUrl':'thumbnail45', 'id':45},
    {'title':'TEST46', 'thumbnailUrl':'thumbnail46', 'id':46},
    {'title':'TEST47', 'thumbnailUrl':'thumbnail47', 'id':47},
    {'title':'TEST48', 'thumbnailUrl':'thumbnail48', 'id':48},
    {'title':'TEST49', 'thumbnailUrl':'thumbnail49', 'id':49},
    {'title':'TEST50', 'thumbnailUrl':'thumbnail50', 'id':50},
  ];

  String _title;
  String _thumbnailUrl;
  int _id;

  PhotoData(this._title, this._thumbnailUrl, this._id);

  factory PhotoData.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    } else {
      return PhotoData(json["title"], json["thumbnailUrl"], json["id"]);
    }
  }

  get title => _title;
  get thumbnailUrl => _thumbnailUrl;
  get id => _id;

}
