<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome IChing Reading</title>
    <link rel="stylesheet" type="text/css"
      href="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css" />
    <script src="http://code.jquery.com/jquery-1.8.0.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.js"></script>
    <link rel="stylesheet" type="text/css" 
      href="${resource(dir:'css',
      file:'ichingreadingjquerymobile.css')}" />
  </head>
  <body>
    <div data-role="page" id="startpage">
      <div data-role="header">
        <h1>IChing Reading</h1>
      </div>
      <div data-role="content">
        <p>
        <a href="${createLink(action: 'readingresulthtml',
          controller:'jquerymobile')}" 
          data-role="button" data-transition="slide">
          Reading
        </a>
        </p>
        <p>
        <a href="${createLink(action: 'readingresulthtml',
          controller:'jquerymobile')}" 
          data-role="button" data-transition="flip">
          <g:img dir = 'images/iching' file = 'IChingReadingButtonN.png' 
            alt='logo' />
        </a>
        </p>
      </div>
    </div>
  </body>
</html>

