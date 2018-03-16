shelfView = function(videos) {

  videos = videos.map((video, index) => videoPartialView(video));

  const template = `
    <document>
      <head>
        <style>
          .overlay {
            padding: 0;
          }
          .resource-watched {
            tv-position: bottom-trailing;
            tv-align: trailing;
          }
          .title {
            font-weight: bold;
          }
          .title, .subtitle {
            text-align: left;
          }
          .image {
            width: 960;
            height: 540;
          }
        </style>
      </head>
      <stackTemplate>
        <banner>
          <title>Subscriptions</title>
        </banner>
        <collectionList>
          <shelf>
            <section>
              ${videos.join("")}
            </section>
          </shelf>
        </collectionList>
      </stackTemplate>
    </document>`;

  const parser = new DOMParser();
  const view = parser.parseFromString(template, "application/xml");

  view.addEventListener("select", eventHandler);
  view.addEventListener("play", eventHandler);
  return view;
};
