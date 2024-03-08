import express from "express";
import {
    createPassword,
    deletePassword,
    updatePassword,
    getAllUserPasswords,
} from "../controllers/password.controller.js";
import { verifyUser } from "../middlewares/auth.middleware.js";

const passwordRoute = express.Router();

passwordRoute.route("/create").post(verifyUser,createPassword);
passwordRoute.route("/delete/:passwordId").delete(verifyUser,deletePassword);
passwordRoute.route("/update/:passwordId").patch(verifyUser,updatePassword);
passwordRoute.route("/get-passwords").get(verifyUser,getAllUserPasswords);

export { passwordRoute };
