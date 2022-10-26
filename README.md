# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

<%= form.select :datos, [
                      ["Lactulosa 10 gr", "0,15,30,45,60,75,90,120,150,180"], 
                      ["Glucosa 75 gr", "0,15,30,45,60,75,90,120"], 
                      ["Lactosa 25 gr", "0,15,30,45,60,75,90,120"],
                      ["Fructosa 25 gr", "0,15,30,45,60,75,90,120"]], 
                      selected: "lactulosa" %>

data = [ %w[Minuto PPM_H2 ],
                 ["#{@minutos[0]}", "#{@datos[0]}"],
                 ["#{@minutos[1]}", "#{@datos[1]}"],
                 ["#{@minutos[2]}", "#{@datos[2]}"],
                 ["#{@minutos[3]}", "#{@datos[3]}"],
                 ["#{@minutos[4]}", "#{@datos[4]}"],
                 ["#{@minutos[5]}", "#{@datos[5]}"],
                 ["#{@minutos[6]}", "#{@datos[6]}"],
                 ["#{@minutos[7]}", "#{@datos[7]}"],
                 ["#{@minutos[8]}", "#{@datos[8]}"],
                 ["#{@minutos[9]}", "#{@datos[9]}"],
                ] 

/*
document.addEventListener('DOMContentLoaded', ()=>{

    console.log("doctores")
    
})
*/

/* event listener */
document.getElementsByName("Thing")[0].addEventListener('change', doThing);

/* function */
function doThing(){
    indexDoctors()
   alert('Horray! Someone wrote "' + this.value + '"!');
}

function indexDoctors(){
    fetch("http://localhost:3000/list/doctors")
        .then(response => response.json())
        .then(data => {
                    //console.log(data)
                    searchDoctor(data)
                });
}

function searchDoctor(doctors){
    let doctor_name = document.getElementById("medico_solicitante").value
    console.log(doctors[0].name)
    console.log(doctors[0].name == doctor_name)
    if (doctors[0].name != doctor_name){
        console.log("diferentes")
        addDoctor(doctor_name)
    }
}

function addDoctor(doctor_name){
    let url = "http://localhost:3000/list/doctors"
    fetch(url, {
        method: 'POST', // or 'PUT'
        headers:{
          'Content-Type': 'application/json',
          'Accept' : 'application/json'
        },
        body: JSON.stringify({
            doctor: {
                name: doctor_name[0].name
            }
        }), // data can be `string` or {object}!
      }).then(res => res.json())
      //.catch(error => console.error('Error:', error))
      .then(response => console.log('Success:', response));
}