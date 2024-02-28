import { Type } from "@sinclair/typebox";

export const cartItemResourceSchema = Type.Object(
  {
    id: Type.Number(),
    name: Type.String(),
    price: Type.Number(),
  },
  { $id: "productResourceSchema" }
);
