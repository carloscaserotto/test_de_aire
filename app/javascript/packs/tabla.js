console.log("tabla js")
$(document).ready(function(){
    $("#button2").click(function(){
      $.get("/search/ajax", function(data, status){
        console.log("Data: " + data + "\n");
        for (const d in data){
          console.log(data[d].id)
          console.log(data[d].name)
          $("#text").append('<li> '+ data[d].name+ ' </li>');
         
        }
      });
    });
  });
  
  
  
  
  