<%@ taglib uri="http://localhost/jeetags" prefix="siga"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
function postbackURL(){
	return '${linkTo[SolicitacaoController].reclassificar}?sigla='+$("#sigla").val()
		+'&itemConfiguracao.id='+$("#formulario_itemConfiguracao_id").val();
}
function validarReclassificacao() {
	$("#itemNaoInformado").hide();
	$("#erroJustificativa").hide();

	if (!$("#formulario_itemConfiguracao_id").val()){
		$("#itemNaoInformado").show();
		return false;
	}
	if (!$("#selectAcao").val()) {
		$("#acaoNaoInformada").show();
		return false;
	}
	return true;
}

</script>
<div class="gt-content-box gt-form">
<form action="${linkTo[SolicitacaoController].reclassificarGravar}" method="post" 
	onsubmit="if (!validarReclassificacao()) return false; jQuery.blockUI(objBlock);" 
	enctype="multipart/form-data" id="frm">
	<input type="hidden" name="todoOContexto" value="${todoOContexto}" />
	<input type="hidden" name="ocultas" value="${ocultas}" />
	<input type="hidden" name="sigla" id="sigla" value="${siglaCompacta}" />
	<div class="gt-form-row">
		<label>Produto, Servi&ccedil;o ou Sistema relacionado &agrave; Solicita&ccedil;&atilde;o</label>
		<siga:selecao2 tamanho="grande" propriedade="itemConfiguracao" tipo="itemConfiguracao" tema="simple" modulo="sigasr"
			onchange="$('#itemNaoInformado').hide();" reler="ajax"
			paramList="sol.solicitante.id=${solicitante.idPessoa};sol.local.id=${local.idComplexo};sol.titular.id=${cadastrante.idPessoa};sol.lotaTitular.id=${lotaTitular.idLotacao}" />
		<br/><span id="itemNaoInformado" style="color: red; display: none;">Item não informado</span>
		<br/>
		<div id="divAcao" depende="itemConfiguracao">
			<c:set var="acoesEAtendentes" value="${acoesEAtendentes}" />
			<c:if test="${not empty itemConfiguracao && not empty acoesEAtendentes}"> 
				<div class="gt-form-row">
					<label>A&ccedil;&atilde;o</label>	
					<select name="acao.id" id="selectAcao" onchange="">
						<c:forEach items="${acoesEAtendentes.keySet()}" var="cat">
							<optgroup  label="${cat.tituloAcao}">
								<c:forEach items="${acoesEAtendentes.get(cat)}" var="tarefa">
									<option value="${tarefa.acao.idAcao}" ${acao.idAcao.equals(tarefa.acao.idAcao) ? 'selected' : ''}> ${tarefa.acao.tituloAcao}</option>
								</c:forEach>					 
							</optgroup>
						</c:forEach>
					</select>
					<br/><span id="acaoNaoInformada" style="color: red; display: none;">Ação não informada</span>
				</div>
			</c:if>
		</div>
	</div>
	<div class="gt-form-row">
		<input type="submit" value="Gravar" class="gt-btn-medium gt-btn-left" />
	</div>
</form>
</div>