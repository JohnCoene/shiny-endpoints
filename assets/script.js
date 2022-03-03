$(function(){
  let path = "";

  Shiny.addCustomMessageHandler("path", (msg) => {
    path = msg;
  });

  $('#get').on('click', (event) => {
    let column = $('#column').val();

    console.log(`${path}&column=${encodeURIComponent(column)}`);

    fetch(`${path}&column=${encodeURIComponent(column)}`)
      .then(response => response.json())
      .then(data => {
        $('#data').text(
          JSON.stringify(data)
        );
      });

    console.log("RAN THIS!")
  });
});
