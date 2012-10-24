<div data-dojo-type="dojox.mobile.ScrollableView">
  <g:set var="koulabels" 
    value="['','初爻','二爻','三爻','四爻','五爻','上爻']" />
  <g:set var="sangiimagedir"
    value="${resource(dir:grailsApplication.config.iching.image.sangi.dir)}/" />
  <g:set var="kousymbolimagedir" 
    value="${resource(dir:grailsApplication.config.iching.image.kou.dir)}/" />
  <g:set var="hexagramimagedir" 
    value="${resource(dir:grailsApplication.config.iching.image.hexagram.dir)}/" />
	
  <h1 data-dojo-type="dojox.mobile.Heading"
    label="Result"
    back="Reading"
    moveTo="startview"
  >
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

