import { FastifyInstance } from "fastify";
import { Type } from "@sinclair/typebox";

import * as cartController from "./controller";
import { cartItemResourceSchema } from "./schema";

export const cartRouter = async (instance: FastifyInstance) => {
  instance.addSchema(cartItemResourceSchema);

  instance.get(
    "/",
    {
      schema: {
        response: {
          200: Type.Object({
            data: Type.Array(Type.Ref(cartItemResourceSchema)),
          }),
        },
      },
    },
    cartController.listItems
  );
};
