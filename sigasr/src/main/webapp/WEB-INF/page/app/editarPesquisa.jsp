<%@ include file="/WEB-INF/page/include.jsp"%>

<siga:pagina titulo="Cadastro de Pesquisa">

<style>
#sortable ul {
        height: 1.5em;
        line-height: 1.2em;
}

.ui-state-highlight {
        height: 1.5em;
        line-height: 1.2em;
}
</style>
<script>
$(function() {

        var jPerguntas = $("#perguntas"),
        perguntas = jPerguntas[0],
        jDialog = $("#dialog"),
        dialog = jDialog[0],
        jDescrPergunta = $("#descrPergunta"),
        jTipoPergunta = $("#tipoPergunta");
       
        $( "#perguntas" ).sortable({placeholder: "ui-state-highlight"});
        $( "#perguntas" ).disableSelection();
       
        $("#botaoIncluir").click(function(){
                jDialog.data('acao"perguntas.incluirItem).dialog('open');
        });
       
        jDialog.dialog({
                autoOpen: false,
                height: 'auto"
                width: 'auto"
                modal: true,
                resizable: false,
                close: function() {
                        jDescrPergunta.val('');
                        jDialog.data('descrPergunta"'');
                        jDialog.data('tipoPergunta"'');
                },
                open: function(){
                        if (jDialog.data("descrPergunta"))
                                jDialog.dialog('option" 'title" 'Alterar Pergunta');
                        else
                                jDialog.dialog('option" 'title" 'Incluir Pergunta');                  
                        jDescrPergunta.val(jDialog.data("descrPergunta"));
                        jTipoPergunta.find("option[value=" + jDialog.data("tipoPergunta") + "]").prop('selected" true);
                }
        });
        $("#modalOk").click(function(){
                var acao = jDialog.data('acao');
                var jTipoEscolhido = jTipoPergunta.find("option:selected");
                acao(jDescrPergunta.val(), jTipoEscolhido.val(), jTipoEscolhido.text(), jDialog.data("id"));
                jDialog.dialog('close');
        });
        $("#modalCancel").click(function(){
                jDialog.dialog('close');
        });

        perguntas["index"] = 0;
        perguntas.incluirItem = function(descr, idTipo, descrTipo, id){
                if (!id)
                        id = 'novo_' + ++perguntas["index"];
                jPerguntas.append("<li style=\"cursor: move\" id =\"" + id + "\"></li>");
                var jNewTr = jPerguntas.find("li:last-child");
                jNewTr.append("<span>" + descr + "</span> - <span style=\"display: inline-block\" id=\"" + idTipo + "\">"
                                + descrTipo + "</span>");
                jNewTr.append("&nbsp;&nbsp;<img src=\"/siga/css/famfamfam/icons/pencil.png\" style=\"visibility:hidden; cursor: pointer\" />");
                jNewTr.append("&nbsp;<img src=\"/siga/css/famfamfam/icons/delete.png\" style=\"visibility: hidden; cursor: pointer\" />");
                jNewTr.find("img:eq(0)").click(function(){
                        var jDivs=jNewTr.find("span");
                        jDialog.data("descrPergunta",jDivs[0].innerHTML)
                                .data("tipoPergunta",jDivs[1].id)
                                .data("id",id)
                                .data("acao", perguntas.alterarItem)
                                .dialog("open");
                });
                jNewTr.find("img:eq(1)").click(function(){
                        perguntas.removerItem(jNewTr.attr("id"));
                });
                jNewTr.mouseover(function(){
                        jNewTr.find("img").css("visibility", "visible");
                });
                jNewTr.mouseout(function(){
                        jNewTr.find("img").css("visibility", "hidden");
                });
        }
        perguntas.alterarItem = function(descr, idTipo, descrTipo, id){
                var jDivs=$("#"+id).find("span");
                jDivs[0].innerHTML = descr;
                jDivs[1].id = idTipo;
                jDivs[1].innerHTML = descrTipo;
        }
        perguntas.removerItem = function(idItem){
                $("#"+idItem).remove();
                perguntas["index"]--;
        }

        <c:forEach items="${pesq.getPerguntaSetAtivas()}" var="pergunta">
                perguntas.incluirItem('${pergunta.descrPergunta}" '${pergunta.tipoPergunta.idTipoPergunta}" '${pergunta.tipoPergunta.nomeTipoPergunta}" ${pergunta.idPergunta});
        </c:forEach>

        $("[value='Gravar']").click(function(){
            	if (!block())
                	return false;
                var jForm = $("form"),
                        params = jForm.serialize();
                jPerguntas.find("li").each(function(i){
                        var jDivs=$(this).find("span");
                        params += '&pesq.perguntaSet[' + i + '].descrPergunta=' + jDivs[0].innerHTML;
                        params += '&pesq.perguntaSet[' + i + '].tipoPergunta.idTipoPergunta=' + jDivs[1].id;
                        params += '&pesq.perguntaSet[' + i + '].ordemPergunta=' + i;
                        if (this.id.indexOf("novo_") < 1)
                                params += '&pesq.perguntaSet[' + i + '].idPergunta=' + this.id;
                });
                location.href = '@{Application.gravarPesquisa()}?' + params;
        });
});
</script>
<div class="gt-bd clearfix">
        <div class="gt-content">
                <h2>Cadastro de Pesquisa de Satisfação</h2>

                <div class="gt-form gt-content-box">
                        <form enctype="multipart/form-data">
                                <c:if test="${pesq?.idPesquisa}"> <input type="hidden" name="pesq.idPesquisa"
                                        value="${pesq.idPesquisa}"> </c:if>
                                <div class="gt-form-row gt-width-66">
                                        <label>Nome</label> <input type="text" name="pesq.nomePesquisa"
                                                value="${pesq?.nomePesquisa}" size="60" />
                                </div>
                                <div class="gt-form-row gt-width-66">
                                        <label>Descrição</label> <input type="text"
                                                name="pesq.descrPesquisa" value="${pesq?.descrPesquisa}" size="60" />
                                </div>
                                <div class="gt-form-row">
                                        <label>Perguntas</label>
                                        <ul id="perguntas" style="color: #365b6d">
                                        </ul>
                                        <input type="button" value="Incluir" id="botaoIncluir"
                                                class="gt-btn-small gt-btn-left" style="font-size: 10px;" />
                                </div>
                                <div class="gt-form-row">
                                        <input type="button" value="Gravar"
                                                class="gt-btn-medium gt-btn-left" /> 
                                       	<a href="@{Application.listarPesquisa}" class="gt-btn-medium gt-btn-left">Cancelar</a>
                                </div>
                        </form>
                </div>
        </div>
</div>

<div id="dialog">
        <div class="gt-content">
                <div class="gt-form gt-content-box">
                        <div class="gt-form-row">
                                <label>Pergunta</label> <input type="text" id="descrPergunta"
                                        name="descrPergunta" value="" size="60" />
                        </div>
                        <div class="gt-form-row">
                                <label>Tipo</label> <sigasr:select name="tipoPergunta" id="tipoPergunta">
                                <c:forEach items="${tipos}" var="tipo"> <sigasr:opcao nome="tipo.idTipoPergunta">
                                ${tipo.nomeTipoPergunta} </sigasr:opcao> </c:forEach> </sigasr:select>
                        </div>
                        <div class="gt-form-row">
                                <input type="button" id="modalOk" value="Ok"
                                        class="gt-btn-medium gt-btn-left" /> <input type="button"
                                        value="Cancelar" id="modalCancel" class="gt-btn-medium gt-btn-left" />
                        </div>
                </div>
        </div>
</div>