<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"  isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<html>
	<head> 
		</head>
			<style>
			    .pill {
			        display: inline-block;
			        padding: 8px 12px;
			        margin: 4px;
			        cursor: pointer;
			        border-radius: 20px;
			        color: #fff;
			    }
			    .pillValue {
			        display: inline-block;
			        padding: 8px 12px;
			        margin: 4px;
			        cursor: pointer;
			        border-radius: 20px;
		            font-weight: bold;
		            background: white;
			    }
			    .details-table {
			        margin-top: 20px;
			        border-collapse: collapse;
			        width: 100%;
			    }
			    .details-table th,
			    .details-table td {
			        border: 1px solid #ddd;
			        padding: 8px;
			        text-align: left;
			    }
			    .details-table th {
			        background-color: #f2f2f2;
			    }


			</style>		

	<body>
		<div style="height:650px;">
			<h1>Dados #</h1>
			<div id="pillContainer"></div>
			<div id="detailsContainer"></div>
		</div>
	</body>

		<snk:load/>

			<script>

	var query1 = `
			SELECT FATO.UF, FATO.NUMNOTA, FATO.VLR, DIM.COLOR FROM (
			SELECT 'SP' UF, '5642' NUMNOTA, 5668.45 AS VLR FROM DUAL
			UNION ALL
			SELECT 'RJ' UF, '5643' NUMNOTA, 10000.45 AS VLR FROM DUAL
			UNION ALL
			SELECT 'MG' UF, '5645' NUMNOTA, 55000.45 AS VLR FROM DUAL
			UNION ALL
			SELECT 'SP' UF, '5646' NUMNOTA, 578.45 AS VLR FROM DUAL
			UNION ALL
			SELECT 'RJ' UF, '5647' NUMNOTA, 700.00 AS VLR FROM DUAL
			UNION ALL
			SELECT 'MG' UF, '5648' NUMNOTA, 450.5 AS VLR FROM DUAL
			UNION ALL
			SELECT 'RJ' UF, '5656' NUMNOTA, 1200.45 AS VLR FROM DUAL
			UNION ALL
			SELECT 'RJ' UF, '5677' NUMNOTA, 2400.0 AS VLR FROM DUAL
			UNION ALL
			SELECT 'SP' UF, '5658' NUMNOTA, 500.50 AS VLR FROM DUAL
			UNION ALL
			SELECT 'PA' UF, '5632' NUMNOTA, 8000 AS VLR FROM DUAL
			) FATO LEFT JOIN (
			SELECT 'SP' UF, 'GREEN' AS COLOR FROM DUAL
			UNION ALL
			SELECT 'RJ' UF, 'PURPLE' AS COLOR FROM DUAL
			UNION ALL
			SELECT 'MG' UF, 'TOMATO' AS COLOR FROM DUAL
			UNION ALL
			SELECT 'PA' UF, 'BLUE' AS COLOR FROM DUAL
			) DIM ON (FATO.UF = DIM.UF)
	`

	var arr = []

// Função para criar PILLs e mostrar detalhes
function createPillsAndDetails() {
	var pillContainer = document.getElementById('pillContainer');
    var detailsContainer = document.getElementById('detailsContainer');
	//A função executeQuery retorna como resultado uma string em formato JSON, com a seguinte estrutura:
	//[{"COLUNA1":"VALOR","COLUNA2":"VALOR"},{"COLUNA1":"VALOR","COLUNA2":"VALOR"}]
	executeQuery(query1,arr,function(value){
		var data = JSON.parse(value);
		console.log("dados:", data)
			if(data.length > 0){
	
			    // Mapeia os status únicos para criar as PILLs
			    var uniqueStatuses = [...new Set(data.map(item => item.UF))];

			    //console.log(uniqueStatuses)

			    uniqueStatuses.forEach(value => {
			        var statusData = data.filter(item => item.UF === value);
			        var color = statusData[0].COLOR; // Assume a cor do primeiro item

			        //Montando a Pill
			        var pill = document.createElement('div');
			        pill.classList.add('pill');
			        pill.style.backgroundColor = color;
			        pill.textContent = value;

			        //Montando o numero dentro da pill
			        var count = statusData.length
	                var pillNum = document.createElement('div');
			        pillNum.classList.add('pillValue');
			        pillNum.style.color = color;
			        // pillNum.style.backgroundColor = 'white';
			        pillNum.textContent = count
			        pill.appendChild(pillNum)


			        pill.onclick = function() {
			            // Ao clicar na PILL, mostra os detalhes na tabela
			            var tableHtml = '<table class="details-table">';
			            tableHtml += '<tr><th>UF</th><th>Nota</th><th>Valor</th></tr>';
			            statusData.forEach(item => {
			                tableHtml += "<tr><td>"+item.UF+"</td><td>"+item.NUMNOTA+"</td><td>"+item.VLR+"</td></tr>";
			            });
			            tableHtml += '</table>';
			            detailsContainer.innerHTML = tableHtml;
			        };
			        console.log(pillContainer, pill)
			        pillContainer.appendChild(pill);
		    });

		}
	},function(value){
		console.log(value)
		alert('Erro em ' + value);
	});



}

// Chama a função para criar as PILLs e detalhes
createPillsAndDetails();


			</script> 
			
</html>
