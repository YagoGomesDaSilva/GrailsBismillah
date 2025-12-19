<meta name="layout" content="public"/>

<div id="global-wrapper">
    <div id="content-wrapper">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 col-md-4 mx-auto">
                    <h1 class="text-center login-title">Contacts Book Member Login</h1>
                    <div class="account-wall">
                        <g:img dir="images" file="grails.svg" class="profile-img"/>
                        <g:if test="${flash.message}">
                            <div class="alert alert-danger" role="alert">
                                ${flash.message.info}
                            </div>
                        </g:if>
                        <g:form controller="authentication" action="doLogin" class="form-signin">
                            <g:textField name="email" class="form-control" placeholder="Email" required="required" />
                            <g:passwordField name="password" class="form-control" placeholder="Password" required="required" />
                            <div class="d-grid gap-2">
                                <g:submitButton class="btn btn-lg btn-primary" name="login" value="Login"/>
                                <g:link controller="authentication" action="registration" class="btn btn-lg btn-primary">Member Registration</g:link>
                            </div>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>