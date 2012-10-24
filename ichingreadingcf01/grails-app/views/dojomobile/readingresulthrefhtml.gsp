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
    <div data-dojo-type="dojox.mobile.ScrollableView">
	
  <h1 data-dojo-type="dojox.mobile.Heading"
    label="Result"
  >
    <div data-dojo-type="dojox.mobile.ToolBarButton"
    label="Reading"
    arrow="left"
    href="${createLink(action: 'indexiconhref' ,controller:'dojomobile')}"
  </div>
  </h1>
  <h2 data-dojo-type="dojox.mobile.RoundRectCategory">
    占 (Reading)
  </h2>
  <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
	  <g:render template="/template/mobilekousresult" model="['result': result]" />
  </div>
  <h2 data-dojo-type="dojox.mobile.RoundRectCategory">
    本卦 (Main result)
  </h2>
  <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
	  <g:render template="/template/mobilehexagramresult" model="['result': result.mainresult]" />
  </div>
  <g:if test="${result.perspectiveresult}" >
  <h2 data-dojo-type="dojox.mobile.RoundRectCategory">
    之卦 (Perspective result)
  </h2>
  <div data-dojo-type="dojox.mobile.RoundRect" shadow="true">
	  <g:render template="/template/mobilehexagramresult" model="['result': result.perspectiveresult]" />
  </div>
  </g:if>
  
	</div>
    <script type="text/javascript">
      require(
        [
          "dojox/mobile/parser","dojox/mobile",
          "dijit/_base/manager","dojox/mobile/deviceTheme",
          "dojox/mobile/compat",
          "dojox/mobile/ToolBarButton",
          "dojox/mobile/RoundRectCategory",
          "dojox/mobile/RoundRect",
          "dojox/mobile/ScrollableView",
          "dojo/domReady!"
        ]);
    </script>
  </body>
</html>

