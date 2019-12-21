// Get those values in runtime
const
    language = process.env.LANGUAGE,
    token = process.env.TOKEN;

require('http')
    .createServer((request, response) => {
        response.write(`Language: ${language}\n`);
        response.write(`Token   : ${token}\n`);
        response.end(`\n`);
    }).listen(3000);