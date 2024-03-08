import express from "express";
import {
    createQuery,
    updateQuery,
    deleteQuery,
    getPasswordQueries,
} from "../controllers/query.controller.js";
import { verifyUser } from '../middlewares/auth.middleware.js';

const queryRoute = express.Router();

queryRoute.route("/create/:passwordId").post(verifyUser,createQuery);
queryRoute.route("/delete/:queryId").delete(verifyUser,deleteQuery);
queryRoute.route("/update/:queryId").patch(verifyUser,updateQuery);
queryRoute.route("/get-queries/:passwordId").get(verifyUser,getPasswordQueries);

export { queryRoute };
