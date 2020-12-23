let requestCounter = 0;


require('http')
    .createServer((request, response) => {
        response.write(`Request # : ${++requestCounter}`);
        response.end();
    }).listen(3000,
        () => {
            console.log('Server is waiting for requests. http://localhost:3000')
        });