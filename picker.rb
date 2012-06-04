header =<<-EOD
<html>
  <head>
    <style type="text/css">
      .gifHolder {
        height: 200px;
        width: 200px;
        border: 5px solid #AAB0BE;
        float: left;
        margin-left: 20px;
        margin-bottom: 20px;
        background-size: 100%;
        overflow: hidden;
      }
      .gifChosen {
        border-color: red;
      }
    </style>
    <script>
      currentGif = false
      function setGif(gifId) {
        gifDiv = document.getElementById(gifId)
        if(currentGif) {
          currentGif.className = "gifHolder"
        }
        gifUrl = gifDiv.getAttribute('data-gif-url')
        gifDiv.className = "gifHolder gifChosen"
        currentGif = gifDiv
        document.cookie = gifUrl;
      }

      function init() {
        divs = document.body.getElementsByClassName("gifHolder")
        for(i in divs) {
          gifDiv = divs[i]
          gifUrl = gifDiv.getAttribute('data-gif-url')
          gifDiv.onclick = Function("setGif(" + gifDiv.id + ")")
          gifDiv.style.background = "url('" + gifUrl + "')"
        }
      }
      window.onload = Function("init()");
    </script>
  </head>
  <body>
EOD
i = 0
gifs = File.open("gifs.txt", "r").read.split("\n")
divs = gifs.collect do |gifUrl|
  i += 1
  "<div id='#{i}' class='gifHolder' data-gif-url='#{gifUrl}'>&nbsp;</div>"
end.compact.join("\n")
footer = <<-EOD
  <body>
</html>
EOD
File.open("picker.html", "w").write([header,divs,footer].join("\n"))
