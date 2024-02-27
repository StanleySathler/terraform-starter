import { setupApp } from "./utils";

/*
 * Start server.
 */
const app = setupApp();
app.listen({ port: 3001, host: "::" }, function (err) {
  if (err) {
    app.log.error(err);
    process.exit(1);
  }
});
