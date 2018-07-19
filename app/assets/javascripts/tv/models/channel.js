class Channel {

  constructor(data) {
    for (var property in data) {
      this[property] = data[property];
    }
  }

  head() {
    return this.data.snippet.channel_title;
  }

  subhead() {
    return "Channel";
  }

  uploadsPlaylist() {
    return this.data.content_details.related_playlists.uploads;
  }

}