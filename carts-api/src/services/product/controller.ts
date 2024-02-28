import { FastifyReply, FastifyRequest } from "fastify";

export const listItems = async (req: FastifyRequest, res: FastifyReply) => {
  res.send({ data: [{ id: 1, name: "iPhone", price: 3599.99 }] });
};
