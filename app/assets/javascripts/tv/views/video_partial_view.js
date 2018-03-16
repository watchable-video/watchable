videoPartialView = (video =>
  `
  <lockup action="VideoLockup" videoID="${video.id}" id="videoPartialView_${video.id}">
      ${videoPartialInnerView(video)}
  </lockup>
  `
);

videoPartialInnerView = function(video) {
  const watched = function() {
    if (video.watched) {
      var template = `<overlay class="overlay">
        <badge src="resource://overlay-checkmark" class="resource-watched" />
      </overlay>`;
    } else {
      var template = "";
    }
    return template
  };

  var template = `
    <img src="${video.poster_frame}" class="image" />
    <title class="title"><![CDATA[${video.data.snippet.title}]]></title>
    <subtitle class="subtitle"><![CDATA[${video.subtitle}]]></subtitle>
    ${watched()}`;

  return template;
};
