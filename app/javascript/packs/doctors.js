/* event listener */
document.getElementsByName("Thing")[0].addEventListener('change', doThing);

/* function */
function doThing(){
    searchDoctor(this.value)
   alert('Horray! Someone wrote "' + this.value + '"!');
}


function searchDoctor(doctor){
    //console.log(doctor)
    //console.log('http://localhost:3000/list/doctors/' + doctor + '')
    fetch('http://localhost:3000/list/doctors/' + doctor + '')
        .then(response => response.json())
        .then(data => {
                    //console.log(data)
                    //console.log(data.id)
                    //console.log(data.name)
                    if(data) {
                        console.log(data)
                    }else{
                        //console.log("New doctor")
                        new_doctor = document.getElementsByName("Thing")[0].value
                        matricula = prompt('Por favor ingrese matricula de "' + new_doctor + '"!');
                        especialidad = prompt('Por favor ingrese la especialidad de "' + new_doctor + '"!');
                        //console.log(new_doctor)
                        //console.log(matricula)
                        addDoctor(new_doctor, matricula, especialidad)
                    }
                    //searchDoctor(data)
                });
}

function addDoctor(nombre,mn,speciality){
    console.log("New doctor")
    console.log(nombre)
    console.log(mn)
    let url = "http://localhost:3000/list/doctors/"+nombre
    console.log(url)
    data = {
        name: nombre,
        mn: mn,
        speciality: speciality,
    }
    fetch(url, {
        method: 'POST',
        headers:  {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: JSON.stringify(data)
      })
    .then(response => response.json())
    .then(result => console.log(result))
    
}