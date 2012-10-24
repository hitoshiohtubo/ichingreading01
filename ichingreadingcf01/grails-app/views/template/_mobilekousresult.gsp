      <div id="koutablebase" class="koutable">
  <g:set var="koulabels" 
    value="['','初爻','二爻','三爻','四爻','五爻','上爻']" />
  <g:set var="sangiimagedir"
    value="${resource(dir:grailsApplication.config.iching.image.sangi.dir)}/" />
  <g:set var="kousymbolimagedir" 
    value="${resource(dir:grailsApplication.config.iching.image.kou.dir)}/" />
        <table>
          <tbody>
            <g:each var="i" in="${(6..1)}">
              <g:set var="sangiimage"
                value="${sangiimagedir + result.kousresult[(i - 1)].kousangiimage}" />
              <g:set var="kousymbolimage"
                value="${kousymbolimagedir + result.kousresult[(i - 1)].kousymbolimage}" />
              <g:set var="kousymbolname"
                value="${result.kousresult[(i - 1)].kousymbolname}" />
              <g:set var="kousymbolenglishname"
                value="${result.kousresult[(i - 1)].kousymbolenglishname}" />
              <tr>
              <td class="koulabelbase">
                <div class="koulabel">${koulabels[i]}</div>
              </td>
              <td class="kousangi">
                <img id="kousangiimage${i}" class="kousangiimage"
                  src="${sangiimage}"
                  alt="sangi image">
                </img>
              </td>
              <td class="kousymbol">
                <img id="kousymbolimage${i}" class="kousymbolimage"
                  src="${kousymbolimage}"
                  alt="kou symbol image">
                </img>
              </td>
              <td class="kousymbolnamebase">
                <div id="kousymbolname${i}" class="kousymbolname" englishname="${kousymbolenglishname}">
                  ${kousymbolname}
                </div>
              </td>
            </tr>
            </g:each>
          </tbody>
        </table>
      </div>



