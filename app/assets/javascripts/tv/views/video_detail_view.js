videoDetailView = function(video) {

  var hd = function() {
    if (video.hd) {
      return `<badge src="resource://hd" />`;
    } else {
      return "";
    }
  };

  const duration = function() {
    const seconds = video.duration_in_seconds;
    if (seconds < 60) {
      return `${seconds} sec`;
    } else {
      const minutes = Math.round(seconds / 60);
      return `${minutes} min`;
    }
  };

  const formatNumber = function(number) {
    const numberFormat = new Intl.NumberFormat();
    return numberFormat.format(number);
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
              <text><![CDATA[${duration()}]]></text>
              <text><![CDATA[${video.full_date}]]></text>
              <text><![CDATA[${formatNumber(video.data.statistics.view_count)} views]]></text>
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
