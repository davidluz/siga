<%@ include file="/WEB-INF/page/include.jsp"%>

<siga:pagina titulo="Buscar Acordo">

<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="//cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>

<script>
	var QueryString = function () {
		// This function is anonymous, is executed immediately and
		// the return value is assigned to QueryString!
		var query_string = {};
		var query = window.location.search.substring(1);
		var vars = query.split("&");
		for (var i=0;i<vars.length;i++) {
			var pair = vars[i].split("=");
	    	// If first entry with this name
	    	if (typeof query_string[pair[0]] === "undefined") {
				query_string[pair[0]] = pair[1];
				// If second entry with this name
			} else if (typeof query_string[pair[0]] === "string") {
				var arr = [ query_string[pair[0]], pair[1] ];
				query_string[pair[0]] = arr;
				// If third or later entry with this name
			} else {
				query_string[pair[0]].push(pair[1]);
			}
		}
		return query_string;
	}();
	
	$(document).ready(function() {
		if (QueryString.mostrarDesativados != undefined) {
			document.getElementById('checkmostrarDesativado').checked = QueryString.mostrarDesativados == 'true';
			document.getElementById('checkmostrarDesativado').value = QueryString.mostrarDesativados == 'true';
		}
			
		$("#checkmostrarDesativado").click(function() {
			if (document.getElementById('checkmostrarDesativado').checked)
				location.href = '@{Application.buscarAcordoDesativadas()}';
			else
				location.href = '@{Application.buscarAcordo()}';	
		});
		
		$('#acordo_table').DataTable({
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
			"columnDefs": [{
				"targets": [2],
				"searchable": false,
				"sortable" : false
			}]
		});
	});
	
	function reativarAcordo(event, id) {
		event.stopPropagation();
		window.location = '@{Application.reativarAcordo()}?' + queryDesativarReativar(id, QueryString.mostrarDesativados);
	}
	
	function desativarAcordo(event, id) {
		event.stopPropagation();
		window.location = '@{Application.desativarAcordo()}?' + queryDesativarReativar(id, QueryString.mostrarDesativados);
	}
</script>

<div class="gt-bd clearfix">
	<div class="gt-content">
		<h2>Acordos</h2>
		<!-- content bomex -->
		<div class="gt-content-box dataTables_div">
			<div class="gt-form-row dataTables_length">
				<label><siga:checkbox name="mostrarDesativado", value:"${mostrarDesativado}" /> <b>Incluir Inativas</b></label>
			</div>
			
			<table id="acordo_table" border="0" class="gt-table display">
				<thead>
					<tr>
						<th>Nome</th>
						<th>Descrição</th>
						<th></th>
					</tr>
				</thead>

				<tbody>
					<c:forEach items="${acordos}" var="acordo">
					<c:choose>
						<c:when test="${popup}">
							<c:set var="onclick" value="javascript:opener.retorna_acordo${nome}('${acordo.idAcordo}','${acordo.idAcordo}','${acordo.nomeAcordo}');window.close()" />
						</c:when>
						<c:otherwise>
							<c:set var="onclick" value="javascript:window.location='@{Application.editarAcordo(acordo.idAcordo)}'" />
						</c:otherwise>
					</c:choose>
					<tr onclick="${onclick}" style="cursor: pointer;">
						<td >${acordo.nomeAcordo}</td>
						<td>${acordo.descrAcordo}</td>
						<td>
							<siga:desativarReativar id="${acordo.idAcordo}"
												onDesativar="desativarAcordo"
												onReativar="reativarAcordo"
												isAtivo="${acordo.isAtivo()}" />
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- /content box -->
		<div class="gt-table-buttons">
		<a href="@{Application.editarAcordo}" class="gt-btn-medium gt-btn-left">Incluir</a>
		</div>

	</div>
</div>

<br />
<br />
<br />
</siga:pagina>