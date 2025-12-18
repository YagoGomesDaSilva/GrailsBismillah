<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
    <g:layoutTitle default="Grails Online Contacts Book"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>
</head>

<body>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-dark rounded">
        <a class="navbar-brand ms-3" href="#">Grails Online Contacts Book</a>
        <button class="navbar-toggler d-lg-none" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        %{--Member Action Menu--}%
        <ul class="navbar-nav ms-auto">
            <UIHelper:memberActionMenu/>
        </ul>
    </nav>
</header>


<div class="container-fluid">
    <div class="row">

        <nav class="col-sm-3 col-md-2 d-none d-sm-block bg-light sidebar">
            <ul class="list-group">
                <UIHelper:leftNavigation/>
            </ul>
        </nav>


        <main role="main" class="col-sm-9 offset-sm-3 col-md-10 offset-md-2 pt-3">
            <g:layoutBody/>
        </main>
    </div>
</div>

<asset:javascript src="application.js"/>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
    <g:if test="${flash?.message && flash?.message?.info}">
    jQuery(document).ready(function () {
        OCB.messageBox.showMessage(Boolean(${flash.message?.success}), "${flash.message?.info}");
    });
    </g:if>
</script>

</body>
</html>