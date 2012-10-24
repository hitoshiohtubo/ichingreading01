<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IChing Engine Test</title>
    <script src="http://code.jquery.com/jquery-1.8.2.js">
    </script>
    <link rel="stylesheet" type="text/css" 
      href="${resource(dir:'css',
      file:'mocha.css')}" />
    <g:javascript src="mocha/mocha.js">
    </g:javascript>
    <g:javascript src="expect/expect.js">
    </g:javascript>
    <script type="text/javascript">
      mocha.setup('bdd');
    </script>
    <g:javascript src="IChingEngine.js">
    </g:javascript>
    <g:javascript src="IChingEngineTest.js">
    </g:javascript>
    <script type="text/javascript">
      $(function () {
        mocha.run();
      });
    </script>
  </head>
  <body>
    <div id="mocha"></div>
  </body>
</html>

