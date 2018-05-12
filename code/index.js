//index js: simple nodejs app.........

//create server, listen on port and respond with hello world
const port = 9000
require('http')
  .createServer((req, res) => {
    console.log('url:', req.url)
    res.end('Hello World! From Node App. Version8<br>')
  })
  .listen(port, (error)=>{
    console.log(`server is now running on ${port}`)
  })

