import http from "k6/http";
import { check, sleep } from "k6";

export let options = {
  stages: [
    { duration: "10s", target: 5000 },
    { duration: "10s", target: 10000 },
    { duration: "10s", target: 5000 },
    { duration: "10s", target: 0 },
  ],
};

const proxy = "socks5://localhost:9050";

export default function() {
  const url = __ENV.K6_URL || '';

  if (url === '') {
    return;
  }

  const params = {
    proxyUrl: proxy,
  };

  let res = http.get(url, params);

  check(res, {
    "status is 200": (r) => r.status === 200,
  });
  sleep(1);
}
