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

}