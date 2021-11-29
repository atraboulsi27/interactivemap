//title,date,source_url,location,description

//format (m['notes'][0][0]);
class Story {
  final String title;
  final String mediaType;
  final String description;
  final String event_date;
  final String location;
  final String source_url;
  final String date_submitted;
  final String status;
  final String featured_image;

  //final Map<String media type, String file> content

  Story(this.title, this.mediaType, this.location, this.source_url, this.description, this.date_submitted, this.event_date, this.status, this.featured_image);

  Story.fromJson(Map<String, dynamic> json)
      : title = json['title']['rendered'],
        mediaType = json['acf']['audio']['type'],
        location = json['acf']['location'],
        description = json['acf']['short_description'],
        date_submitted = json['date'],
        source_url = json['acf']['audio']['url'],
        status = json['status'],
        featured_image = json['better_featured_image']['source_url'],
        event_date = json['acf']['event_date'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'mediaType': mediaType,
        'location': location,
        'description': description,
        'date': date_submitted,
        'event_date': event_date,
        'source_url': source_url,
        'status': status,
      };
}
