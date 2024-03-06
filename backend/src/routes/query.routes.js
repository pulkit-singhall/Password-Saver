import express from "express";
import {
    createQuery,
    updateQuery,
    deleteQuery,
    getPasswordQueries,
} from "../controllers/query.controller.js";

const queryRoute = express.Router();

queryRoute.route("/create/:passwordId").post(createQuery);
queryRoute.route("/delete/:queryId").delete(deleteQuery);
queryRoute.route("/update/:queryId").patch(createQuery);
queryRoute.route("/get-queries/:passwordId").get(getPasswordQueries);

export { queryRoute };
