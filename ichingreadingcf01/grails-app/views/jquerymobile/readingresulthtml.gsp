<div data-role="page" id="resultpage" data-add-back-btn="true" data-back-btn-text="Reading">
  <div data-role="header">
    <h1>Result</h1>
  </div>
  <div data-role="content">
    <div data-role="collapsible" data-collapsed="false">
      <h3>占 (Reading)</h3>
	  <g:render template="/template/mobilekousresult" model="['result': result]" />
    </div>
    <div data-role="collapsible" data-collapsed="false">
      <h3>本卦 (Main result)</h3>
	  <g:render template="/template/mobilehexagramresult" model="['result': result.mainresult]" />
    </div>
    <g:if test="${result.perspectiveresult}" >
    <div data-role="collapsible" data-collapsed="false">
      <h3>之卦 (Perspective result)</h3>
	  <g:render template="/template/mobilehexagramresult" model="['result': result.perspectiveresult]" />
    </div>
    </g:if>
  </div>
</div>

