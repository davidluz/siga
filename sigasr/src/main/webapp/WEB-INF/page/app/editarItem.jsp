<%@ include file="/WEB-INF/page/include.jsp"%>

<siga:pagina titulo="Cadastro de Item">

<style>
.inline {
	display: inline-flex !important;
}

.tabela {
	margin-top: -10px;
	min-width: 200px;
}

.tabela tr {
	border: solid;
	border-color: rgb(169, 169, 169);
	border-width: 1px;
	font-weight: bold;
	line-height: 20px;
}

.tabela th {
	color: #365b6d;
	font-size: 100%;
	padding: 5px 10px;
	border: solid 1px rgb(169, 169, 169);
}

.tabela td {
	color: #000;
	padding-right: 10px !important;
}

.gt-form-table td {
	padding-right: 0px;
}

.barra-subtitulo {
	background-color: #eee;
	color: #365b6d;
	padding: 10px 15px;
	border: 1px solid #ccc;
	border-radius: 0;
	font-weight: bold;
	margin: 0 0 10px -16px;
}

.barra-subtitulo-top {
	border-radius: 5px 5px 0 0;
	margin: -16px 0 10px -16px;
}
</style>

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="//cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
<script src="/sigasr/public/javascripts/jquery.maskedinput.min.js"></script>

<script>
	
	$("#itemConfiguracao").mask("99.99.99");

	//removendo a referencia de '$' para o jQuery
	$.noConflict();

	$(function() {
		// POPUP PARA ADICIONAR UM GESTOR
        var jGestores = $("#gestoresUl"),
        gestores = jGestores[0],
        jDialog = $("#dialog"),
        dialog = jDialog[0],
        jSelect = $("#gestorpessoagestorlotacao");

        $( "#gestoresUl" ).sortable({placeholder: "ui-state-highlight"});
        $( "#gestoresUl" ).disableSelection();
       
        $("#botaoIncluir").click(function(){
        	jDialog.data('acao',gestores.incluirItem).dialog('open');
        });
       
        jDialog.dialog({
                autoOpen: false,
                height: 'auto',
                width: 'auto',
                modal: true,
                resizable: false,
                close: function() {
                	$("#gestorpessoa_sigla").val('');
                	$("#gestorlotacao_sigla").val('');
                	$("#gestorpessoa_descricao").val('');
                	$("#gestorlotacao_descricao").val('');
                	$("#gestorpessoaSpan").html('');  
                	$("#gestorlotacaoSpan").html('');  
                    jDialog.data('gestorSet','');
	            },
	            open: function(){
                    if (jDialog.data("gestorSet"))
                            jDialog.dialog('option', 'title', 'Alterar Gestor');
                    else
                            jDialog.dialog('option', 'title', 'Incluir Gestor');  
	            }
        });
        $("#modalOk").click(function(){
                var acao = jDialog.data('acao');
                var jTipoEscolhido = jSelect.find("option:selected");
                
                if(jTipoEscolhido.val() == 1) {
                	acao($("#gestorpessoa_sigla").val(), $("#gestorpessoa_descricao").val(), 'pessoa', $("#gestorpessoa").val(), jDialog.data("id"));
                } else if (jTipoEscolhido.val() == 2) {
                	acao($("#gestorlotacao_sigla").val(), $("#gestorlotacao_descricao").val(), 'lotacao', $("#gestorlotacao").val(), jDialog.data("id"));
                }
                
                jDialog.dialog('close');
        });
        $("#modalCancel").click(function(){
                jDialog.dialog('close');
        });

        gestores["index"] = 0;
        gestores.incluirItem = function(siglaGestor, nomeGestor, tipoGestor, idDerivadoGestor,  id){
            if (!id)
                id = 'novo_' + ++gestores["index"];
            jGestores.append("<li style=\"cursor: move\" id =\"" + id + "\"></li>");
	        var jNewTr = jGestores.find("li:last-child");
	        jNewTr.append("<span id=\"" + tipoGestor + "\">" + siglaGestor + "</span> - <span style=\"display: inline-block\" id=\"" 
	    	        + idDerivadoGestor + "\">" + nomeGestor + "</span>&nbsp;&nbsp;<img src=\"/siga/css/famfamfam/icons/cross.png\" style=\"cursor: pointer;\" />");
	        jNewTr.find("img:eq(0)").click(function(){
	        	gestores.removerItem(jNewTr.attr("id"));
	        });
	        jNewTr.mouseover(function(){
                jNewTr.find("img").css("visibility", "visible");
	        });
	        jNewTr.mouseout(function(){
                jNewTr.find("img").css("visibility", "hidden");
	        });
  		}
        gestores.removerItem = function(idItem){
                $("#"+idItem).remove();
                gestores["index"]--;
        }

        <c:forEach items="${itemConfiguracao.gestorSet}" var="item">
        	<c:if test="${item.dpPessoa}">
	        	gestores.incluirItem('${item.dpPessoa.sesbPessoa}${item.dpPessoa.matricula}', '${item.dpPessoa.nomePessoa}', 'pessoa', ${item.dpPessoa.idPessoa}, ${item.idGestorItem});
        	</c:if>
	        <c:if test="${item.dpLotacao}">
	        		gestores.incluirItem('${item.dpLotacao.siglaLotacao}', '${item.dpLotacao.nomeLotacao}', 'lotacao', ${item.dpLotacao.idLotacao}, ${item.idGestorItem});
	        </c:if>
		</forEach>

        
// 		POPUP PARA ADICIONAR UM FATOR DE MULTIPLICAÇÃO E SOLICITANTE
        var jFatores = $("#fatoresUl"),
        fatores = jFatores[0],
        jDialogFator = $("#dialogFator"),
        dialogFator = jDialogFator[0],
        jSelectFator = $("#fatorpessoafatorlotacao");
        jNumFatorMult = $("#numfatorMult");

        $( "#fatoresUl" ).sortable({placeholder: "ui-state-highlight"});
        $( "#fatoresUl" ).disableSelection();
       
        $("#botaoIncluirFator").click(function(){
        	jDialogFator.data('acaoFator',fatores.incluirItem).dialog('open');
        });
       
        jDialogFator.dialog({
                autoOpen: false,
                height: 'auto',
                width: 'auto',
                modal: true,
                resizable: false,
                close: function() {
                	$("#fatorpessoa_sigla").val('');
                	$("#fatorlotacao_sigla").val('');
                	$("#fatorpessoa_descricao").val('');
                	$("#fatorlotacao_descricao").val('');
                	$("#numfatorMult").val('1');
                	$("#fatorpessoaSpan").html('');  
                	$("#fatorlotacaoSpan").html('');  
                	jDialogFator.data('fatorMultiplicacaoSet','');
	            },
	            open: function(){
	            	$('#erroNumFatorMult').hide();
                    if (jDialogFator.data("gestorSet"))
                    	jDialogFator.dialog('option', 'title', 'Alterar Fator de Multiplicação');
                    else
                    	jDialogFator.dialog('option', 'title', 'Incluir Fator de Multiplicação');  
	            }
        });
        $("#modalOkFator").click(function(){
                var acaoFator = jDialogFator.data('acaoFator');
                var jTipoEscolhidoFator = jSelectFator.find("option:selected");
                var numFatorMult = $('#numfatorMult');
				
				if(numFatorMult.val() > 0) {
	                if(jTipoEscolhidoFator.val() == 1) {
	                	acaoFator($("#fatorpessoa_sigla").val(), $("#fatorpessoa_descricao").val(), $("#numfatorMult").val(), 'pessoa', $("#fatorpessoa").val(), jDialogFator.data("id"));
	                } else if (jTipoEscolhidoFator.val() == 2) {
	                	acaoFator($("#fatorlotacao_sigla").val(), $("#fatorlotacao_descricao").val(), $("#numfatorMult").val(), 'lotacao', $("#fatorlotacao").val(), jDialogFator.data("id"));
	                }
	                jDialogFator.dialog('close');
				} else {
					$('#erroNumFatorMult').show();
				}
                
                
        });
        $("#modalCancelFator").click(function(){
        	jDialogFator.dialog('close');
        });

        fatores["index"] = 0;
        fatores.incluirItem = function( siglaSolicitante, nomeSolicitante, numFator, tipoFator, idDerivadoFator, idF){
            if (!idF)
                idF = 'novo_fator' + ++fatores["index"];
            jFatores.append("<li style=\"cursor: move\" id =\"" + idF + "\"></li>");
	        var jNewFatorTr = jFatores.find("li:last-child");
	        jNewFatorTr.append("<span id=\"" + tipoFator + "\">" + siglaSolicitante + "-" 
	    	        + nomeSolicitante + "</span> <span style=\"display: inline-block\" id=\"" + idDerivadoFator + "\"> / Fator: "
	                + numFator + "</span>&nbsp;&nbsp;<img src=\"/siga/css/famfamfam/icons/cross.png\" style=\" visibility:hidden; cursor: pointer;\" />");
	        jNewFatorTr.find("img:eq(0)").click(function(){
	        	fatores.removerItemFator(jNewFatorTr.attr("id"));
	        });
	        jNewFatorTr.mouseover(function(){
	        	jNewFatorTr.find("img").css("visibility", "visible");
	        });
	        jNewFatorTr.mouseout(function(){
	        	jNewFatorTr.find("img").css("visibility", "hidden");
	        });
  		};
  		
        fatores.removerItemFator = function(idItemF){
                $("#"+idItemF).remove();
                fatores["index"]--;
        };

        <c:forEach items="${itemConfiguracao.fatorMultiplicacaoSet}" var="itemFator">
        	<c:if test="${itemFator.dpPessoa}">
	        	fatores.incluirItem('${itemFator.dpPessoa.sesbPessoa}${itemFator.dpPessoa.matricula}', '${itemFator.dpPessoa.nomePessoa}', ${itemFator.numFatorMultiplicacao}, 'pessoa', ${itemFator.dpPessoa.idPessoa}, '${itemFator.idFatorMultiplicacao}Fator');
        	</c:if>
	        <c:if test="${itemFator.dpLotacao}"
	        		fatores.incluirItem('${itemFator.dpLotacao.siglaLotacao}', '${itemFator.dpLotacao.nomeLotacao}', ${itemFator.numFatorMultiplicacao}, 'lotacao', ${itemFator.dpLotacao.idLotacao}, '${itemFator.idFatorMultiplicacao}Fator');
	        </c:if>
		</c:forEach>


// 		UTILIZADO TANTO PARA GESTORES QUANTO PARA FATORES DE MULTIPLICAÇÃO
        $("[value='Gravar']").click(function(){
            var jForm = $("form"),
                    params = jForm.serialize();
            jGestores.find("li").each(function(i){
                    var jDivs=$(this).find("span");
                    var tipo = jDivs[0].id;
                    if(tipo === 'pessoa'){
                    	params += '&itemConfiguracao.gestorSet[' + i + '].dpPessoa.idPessoa=' + jDivs[1].id;
                    } else if (tipo === 'lotacao') {
                    	params += '&itemConfiguracao.gestorSet[' + i + '].dpLotacao.idLotacao=' + jDivs[1].id;
                    }                            
            });
            jFatores.find("tr").each(function(i){
                var jDivsF=$(this).find("span");

                if(jDivsF.length == 0) return;
                
                var tipoF = jDivsF[0].id;
                var indice = i-1;
                if(tipoF === 'pessoa'){
                	params += '&itemConfiguracao.fatorMultiplicacaoSet[' + indice + '].dpPessoa.idPessoa=' + jDivsF[1].id;
                } else if (tipoF === 'lotacao') {
                	params += '&itemConfiguracao.fatorMultiplicacaoSet[' + indice + '].dpLotacao.idLotacao=' + jDivsF[1].id;
                }
                	params += '&itemConfiguracao.fatorMultiplicacaoSet[' + indice + '].numFatorMultiplicacao=' + jDivsF[1].innerHTML;
       	 	});
            
            location.href = "@{Application.gravarItem()}?" + params;
        });
	});
</script>

<div class="gt-bd clearfix">
	<div class="gt-content clearfix">

		<h2 class="gt-form-head">Cadastro de Item de Configuração</h2>
		<div class="gt-content-box gt-for-table">
			<form id="form" class="form100" enctype="multipart/form-data">
				<table class="gt-form-table">
					<tr class="header">
						<td align="center" valign="top" colspan="2" style="border-radius: 5px;">Dados Básicos</td>
					</tr>
					<tr>
						<td colspan="2">
							<c:if test="${itemConfiguracao.idItemConfiguracao}">
							<input type="hidden" name="itemConfiguracao.idItemConfiguracao"
								value="${itemConfiguracao.idItemConfiguracao}"> </c:if>
							<c:if test="${itemConfiguracao.hisIdIni}">
							<input type="hidden" name="itemConfiguracao.hisIdIni"
								value="${itemConfiguracao.hisIdIni}"> </c:if>
							<c:if test="${not empty errors}">
							<p class="gt-error">Alguns campos obrigatórios não foram
								preenchidos ${error}</p>
							</c:if>
						</td>
					</tr>
					<tr>
						<td width="5%">
							<label class="inline">Código:</label> 
						</td>
						<td>
							<input
							id="itemConfiguracao" type="text"
							name="itemConfiguracao.siglaItemConfiguracao"
							value="${itemConfiguracao?.siglaItemConfiguracao}" /> <span
							style="color: red;"><sigasr:error
							nome="itemConfiguracao.siglaItemConfiguracao" /></span> 
							
							<label class="inline"
							style="margin-left: 10px;">Título:</label> 
							
							<input type="text"
							id="itemConfiguracao.tituloItemConfiguracao"
							name="itemConfiguracao.tituloItemConfiguracao"
							value="${itemConfiguracao?.tituloItemConfiguracao}" size="84" />
							<span style="display: inline; color: red;"><sigasr:error
							name="itemConfiguracao.tituloItemConfiguracao" /></span>
						</td>
					</tr>
					<tr>
						<td>
							<label class="inline">Descrição:</label> 
						</td>
						<td colspan="2">
							<input type="text"
							name="itemConfiguracao.descrItemConfiguracao"
							value="${itemConfiguracao?.descrItemConfiguracao}" size="119" />
						</td>
					</tr>
					<tr>
						<td>
							<label>Gestores: </label>
						</td>
					</tr>
					<tr>
						<td colspan="3" style="padding: 0 10px;">
							<ul id="gestoresUl" style="color: #365b6d"></ul>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 0px;">
							<input type="button" value="Incluir" id="botaoIncluir"
                                                class="gt-btn-small gt-btn-left" style="font-size: 10px;" />
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<label class="inline">Similaridade (Separar itens com
								ponto e vírgula):</label>
							<textarea cols="81" rows="4"
								name="itemConfiguracao.descricaoSimilaridade"
								id="descricaoSimilaridade">${itemConfiguracao.descricaoSimilaridade}</textarea>
						</td>
					</tr>
				</table>
				<table class="gt-form-table">
					<tr class="header"><td align="center" valign="top" colspan="3">Priorização</td></tr>

					<tr>
						<td width="10.5%">
							<label class="inline">Fator de Multiplicação:</label> 
						</td>
						<td>
							<input onkeypress="javascript: var tecla=(window.event)?event.keyCode:e.which;if((tecla>47 && tecla<58)) return true;  else{  if (tecla==8 || tecla==0) return true;  else  return false;  }"
 								type="text" name="itemConfiguracao.numFatorMultiplicacaoGeral" value="${itemConfiguracao?.numFatorMultiplicacaoGeral}" size="20" />
 								<span style="display: inline; color: red;"><sigasr:error nome="itemConfiguracao.numFatorMultiplicacaoGeral" /></span>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<label class="inline">Fator de Multiplicação por Solicitante:</label> 
						</td>
					</tr>
					<tr>
						<td colspan="3" style="padding: 0 10px;">
							<ul id="fatoresUl" style="color: #365b6d"></ul>
						</td>
					</tr>
					<tr>
						<td style="padding-top: 0px;">
							<input type="button" value="Incluir" id="botaoIncluirFator"
                                                class="gt-btn-small gt-btn-left" style="font-size: 10px;" />
						</td>
					</tr>
				</table>
 				<table class="gt-form-table">
					<tr>
						<td colspan="4">
							<input type="button" value="Gravar"
								class="gt-btn-medium gt-btn-left" /> <a
								href="@{Application.listarItem}"
								class="gt-btn-medium gt-btn-left">Cancelar</a> 
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>

<div id="dialog">
	<div class="gt-content">
		<div class="gt-form gt-content-box">
			<div class="gt-form-row ">
				<label>Gestor: </label>
				<div id="divGestor"><sigasr:pessoaLotaSelecao
					nomeSelPessoa="gestor.pessoa" nomeSelLotacao="gestor.lotacao"
					valuePessoa="${pessoaAtual}" valueLotacao="${lotacaoAtual}"
					disabled="${disabled}" /></div>
			</div>
			<div class="gt-form-row">
				<input type="button" id="modalOk" value="Ok"
					class="gt-btn-medium gt-btn-left" /> <input type="button"
					value="Cancelar" id="modalCancel" class="gt-btn-medium gt-btn-left" />
			</div>
		</div>
	</div>
</div>

<div id="dialogFator">
	<div class="gt-content">
		<div class="gt-form gt-content-box">
			<div class="gt-form-row ">
				<label>Solicitante: </label>
				<div id="divFator"><sigasr:pessoaLotaSelecao
					nomeSelPessoa="fator.pessoa" nomeSelLotacao="fator.lotacao"
					valuePessoa="${pessoaAtual}" valueLotacao="${lotacaoAtual}"
					disabled="${disabled}" /></div>
			</div>
			<div class="gt-form-row ">
				<label>Fator de Multiplicação: </label>
				<input id="numfatorMult" onkeypress="javascript: var tecla=(window.event)?event.keyCode:e.which;if((tecla>47 && tecla<58)) return true;  else{  if (tecla==8 || tecla==0) return true;  else  return false;  }"
					   type="text" name="numfatorMult" value="1" size="43" />
					   <span style="display: none; color: red;" id="erroNumFatorMult">Fator de multiplicação menor que 1</span>
			</div>
			<div class="gt-form-row">
				<input type="button" id="modalOkFator" value="Ok"
					class="gt-btn-medium gt-btn-left" /> <input type="button"
					value="Cancelar" id="modalCancelFator" class="gt-btn-medium gt-btn-left" />
			</div>
		</div>
	</div>
</div>