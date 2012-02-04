<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">

    <!-- BEGIN HtmlKickstart -->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>

    <!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->

    <script type="text/javascript" src="${resource(dir: 'js', file: 'prettify.js')}"></script>      <!-- PRETTIFY -->
    <script type="text/javascript" src="${resource(dir: 'js', file: 'kickstart.js')}"></script>     <!-- KICKSTART -->

    <link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'kickstart.css')}"
          media="all"/>                                                                            <!-- KICKSTART -->
    <link rel="stylesheet" type="text/css" href="${resource(dir: '/', file: 'style.css')}"
          media="all"/>                                                                            <!-- CUSTOM STYLES -->

<!-- END HtmlKickstart -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
    <g:layoutHead/>
    <r:layoutResources/>
</head>

<body>
<a id="top-of-page"></a>

<div id="wrap" class="clearfix">
    <!-- ===================================== END HEADER ===================================== -->

    <!-- Menu Horizontal -->
    <ul class="menu">
        <li><g:link controller="vendor" action="list">Vendors</g:link>
            <ul>
                <li><g:link controller="vendor" action="list"><span class="icon">v</span>List</g:link></li>
                <li><g:link controller="vendor" action="create"><span class="icon">Z</span>Add</g:link></li>
            </ul>
        </li>
        <li><g:link class="current" controller="contract" action="list">Contracts</g:link>
            <ul>
                <li><g:link controller="contract" action="list"><span class="icon">v</span>List</g:link></li>
                <li><g:link controller="contract" action="create"><span class="icon">Z</span>Add</g:link></li>
            </ul>
        </li>
        <li><g:link controller="clause" action="list">Clauses</g:link>
            <ul>
                <li><g:link controller="clause" action="list"><span class="icon">v</span>List</g:link></li>
                <li><g:link controller="clause" action="create"><span class="icon">Z</span>Add</g:link></li>
            </ul>
        </li>
        <li><g:link controller="template" action="list">Templates</g:link>
            <ul>
                <li><g:link controller="template" action="list"><span class="icon">v</span>List</g:link></li>
                <li><g:link controller="template" action="create"><span class="icon">Z</span>Add</g:link></li>
            </ul>
        </li>
    </li>
    </ul>

    <g:layoutBody/>

    <!-- ===================================== START FOOTER ===================================== -->
</div>

<div class="footer" role="contentinfo">
    <sec:ifNotLoggedIn><li><g:link controller='login' action='auth'>Login</g:link></sec:ifNotLoggedIn>
    <sec:ifLoggedIn><li><g:link controller='logout' action='index'>Logout</g:link></sec:ifLoggedIn>
</div>
</div><!-- END WRAP -->


<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
<g:javascript library="application"/>
<r:layoutResources/>
</body>
</html>