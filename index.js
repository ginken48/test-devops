const lynx = require('lynx');

const statsdHost = process.env.STATSD_HOST || 'localhost';
const statsdPort = parseInt(process.env.STATSD_PORT || '8125', 10);
const metrics = new lynx(statsdHost, statsdPort);

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function main() {
  metrics.timing('test.core.delay', Math.random() * 1000);

  return sleep(3000);
}

(async () => {
  console.log("🚀🚀🚀");
  while (true) { await main() }
})()
  .then(console.log, console.error);