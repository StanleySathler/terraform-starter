import { setupApp } from "./utils";

const PORT = Number.parseInt(process.env.PORT ?? "3003"); // Cloud Run requires you to use `process.env.PORT`.
const HOST = "::"; // This is required for Docker environments.

/*
 * Start server.
 */
const app = setupApp();

app.listen({ port: PORT, host: HOST }, function (err) {
  if (err) {
    app.log.error(err);
    process.exit(1);
  }
});
