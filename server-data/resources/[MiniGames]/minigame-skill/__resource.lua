client_script "@np-errorlog/client/cl_errorlog.lua"

ui_page 'index.html'

files {
  "html/index.html",
  "html/scripts.js",
  "html/style.css"
}
client_script {
  "client.lua",
}

export "taskBar"
export "closeGuiFail"