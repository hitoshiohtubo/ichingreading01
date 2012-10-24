      <div id="hexagram${result.resultkind}tablebase" class="hexagramtable">
  <g:set var="hexagramimagedir" 
    value="${resource(dir:grailsApplication.config.iching.image.hexagram.dir)}/" />
        <g:set var="hexagramimage"
          value="${hexagramimagedir + result.hexagramimage}" />
        <g:set var="hexagramname"
          value="${result.hexagramnumber + '. ' + result.hexagramname}" />
        <g:set var="hexagramaliasname"
          value="${result.hexagramaliasname}" />
        <g:set var="hexagramaliasenglishname"
          value="${result.hexagramaliasenglishname}" />
        <table>
          <tbody>
            <tr>
              <td rowspan="3" class="hexagramimagebase">
                <img id="hexagramimage${result.resultkind}" class="hexagramimage"
                  src="${hexagramimage}"
                  alt="hexagram image">
                </img>
              </td>
              <td class="hexagramnamebase">
                <div id="hexagramname${result.resultkind}" class="hexagramname">
                  ${hexagramname}
                </div>
              </td>
            </tr>
            <tr>
              <td class="hexagramaliasbase">
                <div id="hexagramalias${result.resultkind}" class="hexagramalias">
                  ${hexagramaliasname}
                </div>
              </td>
            </tr>
            <tr>
              <td class="hexagramaliasenglishbase">
                <div id="hexagramaliasenglish${result.resultkind}" class="hexagramaliasenglish">
                  ${hexagramaliasenglishname}
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>



