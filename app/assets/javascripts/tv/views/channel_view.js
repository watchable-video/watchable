class ChannelView extends View {

  constructor(channel) {
    super();
    this.channel = channel;
  }

  template() {
    return `
    <document>
      <head>
        <style>
        .title {
          font-weight: bold;
        }
        .title, .subtitle {
          text-align: left;
          tv-text-style: callout;
        }
        .image {
          width: 960;
          height: 540;
        }
        </style>
      </head>
      <productBundleTemplate>
        <banner>
          <stack>
            <title><![CDATA[${this.channel.data.snippet.title}]]></title>
            <description handlesOverflow="true"><![CDATA[${this.channel.data.snippet.description}]]></description>
            <row>
              <buttonLockup>
                <badge src="resource://button-add" />
                <title>Subscribe</title>
              </buttonLockup>
            </row>
          </stack>
          <heroImg src="${this.channel.poster_frame}" width="666" height="666" />
        </banner>
        <shelf>
          <section>
            ${this._videosTemplate()}
          </section>
        </shelf>
      </productBundleTemplate>
    </document>
    `;
  }

  _videosTemplate() {
    return this.channel.videos.map((video, index) => new VideoLockupView(video).template()).join("");
  }


}
