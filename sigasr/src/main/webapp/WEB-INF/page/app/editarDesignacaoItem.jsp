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
	$( document ).ready(function() {
		
			acaoTable = $('#acao_table').dataTable( {
				"language": {
					"emptyTable":     "Não existem resultados",
				    "info":           "Mostrando de _START_ a _END_ do total de _TOTAL_ registros",
				    "infoEmpty":      "Mostrando de 0 a 0 do total de 0 registros",
				    "infoFiltered":   "(filtrando do total de _MAX_ registros)",
				    "infoPostFix":    "",
				    "thousands":      ".",
				    "lengthMenu":     "Mostrar _MENU_ registros",
				    "loadingRecords": "Carregando...",
				    "processing":     "Processando...",
				    "search":         "Filtrar:",
				    "zeroRecords":    "Nenhum registro encontrado",
				    "paginate": {
				        "first":      "Primeiro",
				        "last":       "Último",
				        "next":       "Próximo",
				        "previous":   "Anterior"
				    },
				    "aria": {
				        "sortAscending":  ": clique para ordenação crescente",
				        "sortDescending": ": clique para ordenação decrescente"
				    }
				},
				"columnDefs": [{"targets": [0], "visible": false, "searchable": false},
				               { "width": "5px", "targets": 3 }],
				"iDisplayLength": 3
		    } );
		
			itemConfiguracaoTable = $('#itemConfiguracao_table').dataTable({
				"language": {
					"emptyTable":     "Não existem resultados",
				    "info":           "Mostrando de _START_ a _END_ do total de _TOTAL_ registros",
				    "infoEmpty":      "Mostrando de 0 a 0 do total de 0 registros",
				    "infoFiltered":   "(filtrando do total de _MAX_ registros)",
				    "infoPostFix":    "",
				    "thousands":      ".",
				    "lengthMenu":     "Mostrar _MENU_ registros",
				    "loadingRecords": "Carregando...",
				    "processing":     "Processando...",
				    "search":         "Filtrar:",
				    "zeroRecords":    "Nenhum registro encontrado",
				    "paginate": {
				        "first":      "Primeiro",
				        "last":       "Último",
				        "next":       "Próximo",
				        "previous":   "Anterior"
				    },
				    "aria": {
				        "sortAscending":  ": clique para ordenação crescente",
				        "sortDescending": ": clique para ordenação decrescente"
				    }
				},
				"columnDefs": [{ "targets": [0], "visible": false, "searchable": false},
				               { "width": "80px", "targets": 1 },
				               { "width": "100px", targets: [2,3]},
				               { "width": "320px", targets: [4]},
				               { "width": "5px", targets: [5]}],
				"iDisplayLength": 3
			});
		
		// Delete Item Configuração
		$('#itemConfiguracao_table tbody').on('click" 'a.itemConfiguracao_remove" function () {
			itemConfiguracaoTable.api().row($(this).closest('tr')).remove().draw(false);
		});
		
	 	// Delete Ação
	    $('#acao_table tbody').on( 'click" 'a.acao_remove" function () {
	    	acaoTable.api().row($(this).closest('tr')).remove().draw(false);
	    } );
	});
	
	function modalAbrir(componentId) {
		$("#" + componentId + "_dialog").dialog('open');
	}
	
	function modalFechar(componentId) {
		$("#" + componentId + "_dialog").dialog('close');
	}
	
	function inserirItemConfiguracao() {
		var row = [	$("#itemConfiguracao").val(),
		           	$("#itemConfiguracao_sigla").val(),
		           	$("#itemConfiguracao_descricao").val(),
		           	$("#itemConfiguracao_descricao").val(),
		           	"",
		           	"<a class=\"itemConfiguracao_remove\"><img src=\"/siga/css/famfamfam/icons/delete.png\" style=\"visibility: inline; cursor: pointer\" /></a>"];
		
		itemConfiguracaoTable.api().row.add(row).draw();
        			
		// limpando campos do componente de busca
		$("#itemConfiguracao").val('');
		$("#itemConfiguracao_descricao").val('');
		$("#itemConfiguracao_sigla").val('');
		$("#itemConfiguracaoSpan").html('');
		
		modalFechar('itemConfiguracao');
	}
	
	function inserirAcao() {
		var row = [	$("#acao").val(),
        			$("#acao_sigla").val(),
        			$("#acao_descricao").val(),
        			"<a class=\"acao_remove\"><img src=\"/siga/css/famfamfam/icons/delete.png\" style=\"visibility: inline; cursor: pointer\" /></a>"];
		
		acaoTable.api().row.add(row).draw();
		
		// limpando campos do componente de busca
		$("#acao").val('');
		$("#acao_descricao").val('');
		$("#acao_sigla").val('');
		$("#acaoSpan").html('');
		
		modalFechar('acao');
	}
</script>

<div class="gt-form gt-content-box" style="width: 800px !important; max-width: 800px !important;">
	<input type="hidden" id="idConfiguracao" name="idConfiguracao" value="${idConfiguracao}" />
	<div>
		<div class="gt-form-row box-wrapper">
			<div id="divSolicitante" class="box box-left gt-width-50">
				<label>Solicitante</label>
				<sigasr:pessoaLotaFuncCargoSelecao
					nomeSelLotacao="lotacao"
					nomeSelPessoa="dpPessoa"
					nomeSelFuncao="funcaoConfianca"
					nomeSelCargo="cargo"
					nomeSelGrupo="cpGrupo"
					valuePessoa="${dpPessoa?.pessoaAtual}"
					valueLotacao="${lotacao?.lotacaoAtual}"
					valueFuncao="${funcaoConfianca}"
					valueCargo="${cargo}"
					valueGrupo="${cpGrupo}"
					disabled="${disabled}" />
			</div>
			<div class="box gt-width-50">
				<label>Órgão</label> 
				<sigasr:select name="orgaoUsuario" 
					items="${_orgaos}"
					valueProperty="idOrgaoUsu"
					labelProperty="nmOrgaoUsu"
					value="${orgaoUsuario?.idOrgaoUsu}"
					class="select-siga"
					style="width: 100%;">
				<sigasr:opcao valor="0">Nenhum</sigasr:opcao> 
				</sigasr:select>
			</div>
		</div>
		
		<div class="gt-form-row box-wrapper">
			<div class="box box-left gt-width-50">
				<label>Local</label> 
				<sigasr:select name="complexo" 
					items="${_locais}" 
					valueProperty="idComplexo"
					labelProperty="nomeComplexo" 
					value="${complexo?.idComplexo}"
					class="select-siga"
					style="width: 100%">
					<sigasr:opcao valor="0">Nenhum</sigasr:opcao> 
				</sigasr:select>
			</div>
			<div class="box gt-width-50">
				<label>Atendente</label><sigasr:selecao
					tipo="lotacao" nome="atendente" value:"${atendente?.lotacaoAtual" />
				<span style="display:none;color: red" id="designacao.atendente">Atendente não informado;</span>
			</div>
		</div>	
			
		<div class="gt-form-row box-wrapper">
			<div class="box box-left gt-width-50">
				<label>Pré-atendente</label><sigasr:selecao
					tipo="lotacao" nome="preAtendente"
					value:"${preAtendente?.lotacaoAtual}" />
				<span style="display:none;color: red" id="designacao.preAtendente">Pré-Atendente não informado.</span>
			</div>

			<div class="box gt-width-50">
				<label>Pós-atendente</label> <sigasr:selecao
					tipo="lotacao" nome="posAtendente"
					value="${posAtendente?.lotacaoAtual} />
				<span style="display:none;color: red" id="designacao.posAtendente">Pós-Atendente não informado.</span>
			</div>
		</div>
		<div class="gt-form-row box-wrapper">
			<div class="box box-left gt-width-50">
				<label>Equipe de Qualidade</label> <sigasr:selecao
					tipo="lotacao" nome="equipeQualidade"
					value="${equipeQualidade?.lotacaoAtual}" />
				<span style="display:none;color: red" id="designacao.equipeQualidade">Equipe de qualidade não informada.</span>
			</div>
			<div class="box gt-width-50">
				<label>Pesquisa de satisfação</label> 
					<sigasr:select name="pesquisaSatisfacao" 
						items="${_pesquisaSatisfacao}" 
						valueProperty="idPesquisa"
						labelProperty="nomePesquisa" 
						value="${pesquisaSatisfacao?.idPesquisa}"
						class="select-siga"
						style="width: 100%;">
						<sigasr:opcao valor="0">Nenhuma</sigasr:opcao> 
					</sigasr:select>
			</div>
		</div>

		<hr/>
		<div class="gt-content">
			<label>Itens de Configuração</label>
			<!-- content bomex -->
			<div class="gt-content-box dataTables_div">
				<table id="itemConfiguracao_table" border="0" class="gt-table-nowrap display">
					<thead>
						<tr>
							<th >ID</th>
							<th>Sigla</th>
							<th>Titulo</th>
							<th>Descrição</th>
							<th>Itens Similares</th>
							<th></th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="item" items="${itemConfiguracaoSet}">
						<tr>
							<td>${item?.id }</td>
							<td>${item?.sigla}</td>
							<td>${item?.tituloItemConfiguracao}</td>
							<td>${item?.descricao }</td>
							<td>${item?.descricaoSimilaridade }</td>
							<td><a class="itemConfiguracao_remove"><img src="/siga/css/famfamfam/icons/delete.png" style="visibility: inline; cursor: pointer" /></a></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="gt-table-buttons">
				<a href="javascript: modalAbrir('itemConfiguracao')" class="gt-btn-small gt-btn-left">Incluir</a>
			</div>
		</div>
		
		<hr/>
		<div class="gt-form-row">
			<label>Ações</label>
			<!-- content bomex -->
			<div class="gt-content-box dataTables_div">
				<table id="acao_table" border="0" class="gt-table display">
					<thead>
						<tr>
							<th>ID</th>
							<th>Sigla</th>
							<th>Título</th>
							<th></th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach items="${acoesSet} var="acao'>
						<tr>
							<td>${acao?.id }</td>
							<td>${acao?.sigla}</td>
							<td>${acao?.tituloAcao }</td>
							<td><a class="acao_remove"><img src="/siga/css/famfamfam/icons/delete.png" style="visibility: inline; cursor: pointer" /></a></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="gt-table-buttons">
				<a href="javascript: modalAbrir('acao')" class="gt-btn-small gt-btn-left">Incluir</a>
			</div>
		</div>
		
		<div class="gt-form-row">
			<div class="gt-form-row">
				<a href="javascript: if (block()) gravarDesignacao();" class="gt-btn-medium gt-btn-left">Ok</a>
				<a href="javascript: designacaoModalFechar()" class="gt-btn-medium gt-btn-left">Cancelar</a>
			</div>
		</div>
		
		
		
		<div class="gt-form-row gt-width-100">
			<p class="gt-error" style="display:none;" id="erroCamposObrigatorios">Alguns campos obrigatórios não foram
				preenchidos.</p>
		</div>
	</div>
</div>

<sigasr:modal nome="itemConfiguracao" titulo="Adicionar Item de Configuração">
	<script>
	//Edson: esta funcao evita que o usuario de ok sem a busca por ajax ter terminado
	function bloqueiaItemOk(){
		$("#modalItemOk").attr("disabled", "disabled");
	}
	function bloqueiaItemOkSeVazio(){
		if ($("#itemConfiguracao").val() && $("#itemConfiguracao_sigla").val() && $("#itemConfiguracaoSpan").text())
			$("#modalItemOk").removeAttr('disabled');
		else 
			$("#modalItemOk").attr("disabled", "disabled");
	}
	</script>
	<div id="dialogItemConfiguracao">
		<div class="gt-content">
			<div class="gt-form gt-content-box">
				<div class="gt-form-row">
					<div class="gt-form-row">
						<label>Item de Configuração</label> <sigasr:selecao tipo="item"
							nome="itemConfiguracao"
							value:"${itemConfiguracao?.atual}" onblur="bloqueiaItemOk();" onchange="bloqueiaItemOkSeVazio();" />
						<span style="display:none;color: red" id="designacao.itemConfiguracao">Item de Configuração não informado.</span>
					</div>
					<div class="gt-form-row">
						<button id="modalItemOk" onclick="javascript: inserirItemConfiguracao()" class="gt-btn-medium gt-btn-left" disabled>Ok</button>
						<a href="javascript: modalFechar('itemConfiguracao')" class="gt-btn-medium gt-btn-left">Cancelar</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</sigasr:modal>

<sigasr:modal nome="acao" titulo="Adicionar Ação'>
	<script>
	//Edson: esta funcao evita que o usuario de ok sem a busca por ajax ter terminado
	function bloqueiaAcaoOk(){
		$("#modalAcaoOk").attr("disabled", "disabled");
	}
	function bloqueiaAcaoOkSeVazio(){
		if ($("#acao").val() && $("#acao_sigla").val() && $("#acaoSpan").text())
			$("#modalAcaoOk").removeAttr('disabled');
		else 
			$("#modalAcaoOk").attr("disabled", "disabled");
	}
	</script>
	<div id="dialogAcao">
		<div class="gt-content">
			<div class="gt-form gt-content-box">
				<div class="gt-form-row">
					<div class="gt-form-row">
						<label>Ação</label> <sigasr:selecao tipo="acao"
							nome="acao" value:"${acao?.atual}" onblur="bloqueiaAcaoOk();" onchange="bloqueiaAcaoOkSeVazio();" />
						<span style="display:none;color: red" id="designacao.acao">Ação não informada.</span>
					</div>
					<div class="gt-form-row">
						<button id="modalAcaoOk" onclick="javascript: inserirAcao()" class="gt-btn-medium gt-btn-left" disabled>Ok</button>
						<a href="javascript: modalFechar('acao')" class="gt-btn-medium gt-btn-left">Cancelar</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</sigasr:modal>