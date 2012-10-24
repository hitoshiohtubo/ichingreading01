<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome IChing Reading</title>
    <script src="//ajax.googleapis.com/ajax/libs/dojo/1.8.0/dojo/dojo.js"
      data-dojo-config="parseOnLoad: true, async: true">
    </script>
    <link rel="stylesheet" type="text/css" 
      href="${resource(dir:'css',
      file:'ichingreadingdojomobile.css')}" />
  </head>
  <body>
    <div id="startview" data-dojo-type="dojox.mobile.ScrollableView" selected="true">
      <h1  data-dojo-type="dojox.mobile.Heading">
        IChing Reading
      </h1>
      <ul data-dojo-type="dojox.mobile.IconContainer"
        single="true"
        >
        <li data-dojo-type="dojox.mobile.IconItem"
          label="Reading"
          icon="${resource(dir:'images/iching', file:'Yin_yang_T_65.png')}"
          transition="slide"
          url="${createLink(action: 'readingresulturlhtml',
            controller:'dojomobile')}"
          sync = "false"
          >
        </li>
      </ul>
    </div>
    <script type="text/javascript">
      require(
        [
          "dojox/mobile/parser","dojox/mobile",
          "dijit/_base/manager","dojox/mobile/deviceTheme",
          "dojox/mobile/compat","dojox/mobile/IconContainer",
          "dojox/mobile/IconItem",
          "dojox/mobile/ScrollableView",
          "dojox/mobile/RoundRectCategory",
          "dojox/mobile/RoundRect",
          "dojo/domReady!"
        ]);
    </script>

  </body>
</html>


