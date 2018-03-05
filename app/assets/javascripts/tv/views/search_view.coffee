this.searchView = ->

  template = """
  <?xml version="1.0" encoding="UTF-8"?>
  <document>
    <searchTemplate>
      <searchField/>
      <list>
        <section>
          <listItemLockup>
            <img src="https://i.ytimg.com/vi/VYHZmmnQxyI/hqdefault.jpg" width="90" height="135" />
            <title>Title</title>
            <subtitle>Subtitle</subtitle>
          </listItemLockup>
          <listItemLockup>
            <img src="https://i.ytimg.com/vi/VYHZmmnQxyI/hqdefault.jpg" width="90" height="135" />
            <title>Title</title>
            <subtitle>Subtitle</subtitle>
          </listItemLockup>
        </section>
      </list>
    </searchTemplate>
  </document>
  """

  parser = new DOMParser();
  parser.parseFromString(template, "application/xml");
