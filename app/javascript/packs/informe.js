console.log("hola")

let informe = document.getElementById("estudio");
//var e = document.getElementById("ddlViewBy";
informe.addEventListener('change', get_study)

   //let estudio = event.target.value; // get selected VALUE 
   //get selected VALUE even outside event handler 
   //console.log(informe.options[informe.selectedIndex].value);
  function get_study(){ 
    //console.log(informe)   
    let estudio = informe.value 
    //console.log(estudio) 
    switch (estudio) {
        case 'lactulosa':
          document.getElementById("datos").value = "0,15,30,45,60,75,90,120,150,180";
          break;
        case 'glucosa':
          document.getElementById("datos").value = "0,15,30,45,60,75,90,120";
          break;
        case 'lactosa':
          document.getElementById("datos").value = "0,15,30,45,60,75,90,120";
          break;
        case 'fructosa':
          document.getElementById("datos").value = "0,15,30,45,60,75,90,120";
          break;
        default:
          console.log('No hay datos');
      }
      let minutos = document.getElementById("datos");
      let min = minutos.value
      generateTable(min)
    }


    function generateTable(min) {
      console.log("tabla")
      console.log(typeof(min))
      var min_arr = min.split(',').map(i=>Number(i));
      console.log(min_arr.length)
      console.log(typeof(min_arr))
       // creates a <table> element and a <tbody> element
       const tbl = document.createElement("table");
       const tblBody = document.createElement("tbody");
      // creating all cells
      for (let i = 0; i < 2; i++) {
        // creates a table row
        const row = document.createElement("tr");
        for (let j = 0; j < 2; j++) {
          // Create a <td> element and a text node, make the text
          // node the contents of the <td>, and put the <td> at
          // the end of the table row
          const cell = document.createElement("td");
          const cellText = document.createTextNode(`cell in row ${i}, column ${j}`);
          cell.appendChild(cellText);
          row.appendChild(cell);
        }
         // add the row to the end of the table body
    tblBody.appendChild(row);
  }

  // put the <tbody> in the <table>
  tbl.appendChild(tblBody);
  // appends <table> into <body>
  document.body.appendChild(tbl);
  // sets the border attribute of tbl to '2'
  tbl.setAttribute("border", "2");
    }
    


