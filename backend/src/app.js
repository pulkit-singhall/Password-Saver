import express from "express";
import dotenv from "dotenv";
import { userRoute } from "./routes/user.routes.js";
import { passwordRoute } from "./routes/password.routes.js";
import { queryRoute } from "./routes/query.routes.js";

dotenv.config();

const app = express();

// middlewares


// routes
app.use("api/v1/users", userRoute);
app.use("api/v1/passwords", passwordRoute);
app.use("api/v1/queries", queryRoute);

export default app;
