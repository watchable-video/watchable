videoDetailView = function(video) {

  var hd = function() {
    if (video.hd) {
      return `<badge src="resource://hd" />`;
    } else {
      return "";
    }
  };

  const template = `
    <document id="videoDetailView_${video.id}">
      <productTemplate theme="dark">
        <banner>

          <stack>
            <title style="font-size: 45pt;"><![CDATA[${video.data.snippet.title}]]></title>
            <row>
              <text style="font-weight: bold;"><![CDATA[${video.data.snippet.channel_title}]]></text>
            </row>
            <row>
              <text><![CDATA[${video.duration()}]]></text>
              <text><![CDATA[${video.full_date}]]></text>
              <text><![CDATA[${video.viewCount()} views]]></text>
              ${hd()}
            </row>

            <description><![CDATA[${video.data.snippet.description}]]></description>
            <row>
              <buttonLockup action="VideoPlay" videoID="${video.id}">
                <badge src="resource://button-play" />
                <title>Play</title>
              </buttonLockup>
              <buttonLockup action="ToggleWatched" videoID="${video.id}" id="watchedButtonView_${video.id}">
              ${watchedButtonView(video)}
              </buttonLockup>
            </row>
          </stack>

          <heroImg src="${video.poster_frame}" style="width: 800pt;" />
        </banner>

      </productTemplate>
    </document>`;

  const parser = new DOMParser();
  const view = parser.parseFromString(template, "application/xml");

  view.addEventListener("play", eventHandler);
  view.addEventListener("select", eventHandler);

  return view;
};

watchedButtonView = (video =>
  `
  <badge src="resource://button-checkmark" />
  <title>${video.watched ? "Unwatched" : "Watched"}</title>
  `
);
