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

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<asset:javascript src="application.js"/>

<script type="text/javascript">
    var BASE_URL = "${createLink(uri: '/', absolute: true)}";
    
    function addContactDetail(btn) {
        console.log("addContactDetail chamado");
        var $btn = $(btn);
        var $row = $btn.closest('.contact-detail-row');
        var hasDeleteButton = $row.find('.btn-remove-detail').length > 0;
        
        $.ajax({
            url: BASE_URL + "contactDetails/create",
            type: "GET",
            dataType: "html",
            success: function (content) {
                console.log("Sucesso ao adicionar");
                $('.details-panel').append(content);
                // Apenas remove o botão de adicionar que foi clicado
                // O botão de excluir (se existir) continua no lugar
                $btn.remove();
            },
            error: function(xhr, status, error) {
                console.error("Erro:", error);
                alert("Erro ao adicionar: " + error);
            }
        });
        return false;
    }

    function ensureAddButton() {
        // Verifica se existe algum botão de adicionar
        if ($('.details-panel .btn-add-detail').length === 0) {
            var $rows = $('.details-panel .contact-detail-row');
            if ($rows.length > 0) {
                // Adiciona o botão de adicionar ao último detail existente
                var $lastRow = $rows.last();
                var $buttonsArea = $lastRow.find('.phone-number-area');
                $buttonsArea.append('<button type="button" class="btn btn-primary btn-add-detail ms-1" onclick="addContactDetail(this); return false;"><i class="fas fa-plus-circle"></i></button>');
            } else {
                // Não há nenhum detail, adiciona um form em branco
                $.ajax({
                    url: BASE_URL + "contactDetails/create",
                    type: "GET",
                    dataType: "html",
                    success: function (content) {
                        $('.details-panel').append(content);
                    }
                });
            }
        }
    }

    function removeContactDetail(btn, contactId) {
        console.log("removeContactDetail chamado, id:", contactId);
        var $btn = $(btn);
        var $row = $btn.closest(".contact-detail-row");

        if(confirm('Tem certeza que deseja excluir?')) {
            if(contactId !== undefined && contactId !== null){
                $.ajax({
                    url: BASE_URL + "contactDetails/delete/" + contactId,
                    type: "POST",
                    dataType: "json",
                    success: function (content) {
                        console.log("Resposta:", content);
                        if(content.success === true){
                            $row.remove();
                            ensureAddButton();
                        } else {
                            alert(content.info || "Erro ao excluir");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Erro:", error);
                        alert("Erro ao excluir: " + error);
                    }
                });
            } else {
                $row.remove();
                ensureAddButton();
            }
        }
        return false;
    }
</script>

</body>
</html>