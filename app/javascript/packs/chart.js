
console.log("Test de aire chart")

let chart_form =document.getElementById("tabla_chart");
let btn_elegir =document.getElementById("elegir");
let btn_graficar_chart = document.getElementById("graficar_chart");
let btn_form_to_pdf = document.getElementById("form_to_pdf");

let canvas=document.getElementById("myChart");
canvas.style.display="none";
btn_graficar_chart.style.display="none";
btn_form_to_pdf.style.display="none";


btn_elegir.addEventListener("click", showBtnGraficar);
btn_graficar_chart.addEventListener("click", gatherData);
btn_form_to_pdf.addEventListener("click", populateInfo);



function showBtnGraficar(){
    btn_graficar_chart.style.display="inline";
}


function gatherData(){
    btn_form_to_pdf.style.display="inline";
    let tabla_chart =document.getElementById("tabla_chart");
    let minutos =[];
    let ppm_h2 = [];
    
    for (r = 1; r < tabla_chart.rows.length; r++) {
        var cells = tabla_chart.rows[r].cells;        
        for (c = 0; c < cells.length; c++){
            var cell = cells[c];
            var inputElem = cell.children[0];
            var isInput = inputElem instanceof HTMLInputElement;
            
            if (!isInput){
                minutos.push(cell.innerText)
            } else {
                ppm_h2.push(cell.children[0].value)
            }
        }               

    }
    let chart_minutos =document.getElementById("minutos");
    let chart_ppmh2 =document.getElementById("ppmh2");
    chart_minutos.value = minutos
    chart_ppmh2.value = ppm_h2
        
    m = minutos.map(i=>Number(i))
    p = ppm_h2.map(i=>Number(i))
    max_y_value = arrayMax(p)
    
    graficar(minutos,ppm_h2,max_y_value);
    
    
}

function arrayMax(arr) {
    return arr.reduce(function (p, v) {
      return ( p > v ? p : v );
    });
}

function graficar(minutos,ppmh2,max_y_value){
    canvas.style.display= "block";
    
    var xValues = minutos
    var yValues = ppmh2
    var yMax = max_y_value
  
    var ctx = document.getElementById('myChart');

    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: xValues,
            datasets: [{
                fill: false,
                lineTension: 0,
                backgroundColor: "rgba(0,0,255,1.0)",
                borderColor: "rgba(0,0,255,0.1)",
                data: yValues,
                label: 'PPM H2'
            }]
        },
        options: {
            responsive: true,
            title: {
                display: true,
                text: "PPM H2"
            },
            tooltips: {
                mode: 'index',
                intersect: false,
                
            },
            legend: { 
                display: false 
            },
            scales: {
                xAxes: [{
                    ticks: {
                        beginAtZero: true,
                        stepSize: 1,
                        autoSkip: false
                    },
                }],
                yAxes: [{
                    gridLines: {
                        color: "rgba(0, 0, 0, .05)",
                    },
                    ticks: {
                        beginAtZero: true,   // minimum value will be 0.
                        stepSize: 1,
                        max: yMax+10
                    }
                }]
            },
            animation: {
                onComplete: done,
            },
        }
    });

    function done(){
        console.log("DONE")
        var url_base64 = document.getElementById('myChart').toDataURL('image/png');
        //console.log(url_base64)
        let form = document.getElementById('pdf_chart');
        form.value = url_base64
        let chart_minutos = document.getElementById('chart_minutos');
        let chart_ppmh2 = document.getElementById('chart_ppmh2');
        chart_ppmh2.value = yValues
        chart_minutos.value = xValues
        
    };
}

function populateInfo(){
    console.log("Populando info")
    let sustrato = document.getElementById("datos");
    let sustrato_index = sustrato.selectedIndex;
    let sustrato_choose = sustrato.options;
    document.getElementById("pdf_sustrato").value = sustrato_choose[sustrato_index].text;
    document.getElementById("pdf_paciente").value = document.getElementById("paciente").innerText;
    document.getElementById("pdf_cobertura_medica").value = document.getElementById("cobertura").innerText;
    document.getElementById("pdf_medico_revisor").value = document.getElementById("revisor").innerText;
    document.getElementById("pdf_especialidad_medica").value = document.getElementById("especialidad").innerText;
    document.getElementById("pdf_matricula_medica").value = document.getElementById("matricula").innerText;
    document.getElementById("pdf_comentario").value = document.getElementById("comentario").innerText;
    
    //console.log(sustrato_choose[sustrato_index].text);
    //console.log(sustrato.value)
    let medico_solicitante = document.getElementById("medico_solicitante");
    //console.log(medico_solicitante.value)
    let comentario = document.getElementById("comentario");
    //console.log(comentario.value)
    
    let tabla_chart =document.getElementById("tabla_chart");
    let minutos =[];
    let ppm_h2 = [];
    
    for (r = 1; r < tabla_chart.rows.length; r++) {
        var cells = tabla_chart.rows[r].cells;        
        for (c = 0; c < cells.length; c++){
            var cell = cells[c];
            var inputElem = cell.children[0];
            var isInput = inputElem instanceof HTMLInputElement;
            
            if (!isInput){
                minutos.push(cell.innerText)
            } else {
                ppm_h2.push(cell.children[0].value)
            }
        }               

    }
    document.getElementById("pdf_medico_solicitante").value = medico_solicitante.value;
    document.getElementById("pdf_comentario").value = comentario.value;
    let pdf_minutos =document.getElementById("pdf_minutos");
    let pdf_ppmh2 =document.getElementById("pdf_ppmh2");
    pdf_minutos.value = minutos
    pdf_ppmh2.value = ppm_h2
    
          

}


