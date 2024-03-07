import express from "express";
import dotenv from "dotenv";
import { userRoute } from "./routes/user.routes.js";
import { passwordRoute } from "./routes/password.routes.js";
import { queryRoute } from "./routes/query.routes.js";
import cookieParser from "cookie-parser";
import cors from "cors";
import { limit } from "./constants.js";

dotenv.config();

const app = express();

// middleware / configurations
// cross origin resource sharing
app.use(
    cors({
        origin: process.env.CORS_ORIGIN,
        credentials: true,
    })
);

// data modifications
// data coming from json
app.use(
    express.json({
        limit: limit,
    })
);

// data coming from URL
app.use(
    express.urlencoded({
        extended: true, // for nested objects
        limit: limit,
    })
);

// public assets like files, pdfs, images etc
app.use(express.static("public"));

// cookies
app.use(cookieParser());

// routes
app.use("/api/v1/users", userRoute);
app.use("/api/v1/passwords", passwordRoute);
app.use("/api/v1/queries", queryRoute);

export default app;
