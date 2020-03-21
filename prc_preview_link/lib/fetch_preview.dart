import 'package:http/http.dart';
import 'package:html/parser.dart';

class FetchPreview {

  Future fetch(url) async {
    if (url == null) return null;

    final client = Client();
    final response = await client.get(validateUrl(url));
    final document = parse(response.body);

    String title, description, image, favIcon;
    var elements = document.getElementsByTagName('meta');
    // get title, description, image
    elements.forEach((tmp) {
      // title
      if (tmp.attributes['property'] == 'og:title') {
        title = tmp.attributes['content'];
      }

      // description
      if (tmp.attributes['property'] == 'og:description') {
        description = tmp.attributes['content'];
      }
      if (description == null || description.isEmpty) {
        if (tmp.attributes['name'] == 'description') {
          description = tmp.attributes['content'];
        }
      }

      // image
      if (tmp.attributes['property'] == 'og:image') {
        image = tmp.attributes['content'];
      }

    });

    if (title == null || title.isEmpty) {
      title = document.getElementsByTagName('title')[0].text;
    }

    // get favIcon
    var linkElements = document.getElementsByTagName('link');
    linkElements.forEach((tmp) {
      if (tmp.attributes['rel']?.contains('icon') == true) {
        favIcon = tmp.attributes['href'];
      }
    });
    if (image == null || image.isEmpty) {
      image = favIcon;
    }

    print(title);
    print(description);
    print(image);
    print(favIcon);

    return {
      'title' : title ?? '',
      'description' : description ?? '',
      'image' : image ?? '',
      'favIcon' : favIcon ?? '',
    };
  }

  String validateUrl(String url) {
    if (url == null) return null;
    if (url.startsWith('http://') == true || url.startsWith('https://') == true) {
      return url;
    } else {
      return 'https://$url';
    }
  }
}