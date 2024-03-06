import express from "express";
import {
    createPassword,
    deletePassword,
    updatePassword,
    getAllUserPasswords,
} from "../controllers/password.controller.js";

const passwordRoute = express.Router();

passwordRoute.route("/create").post(createPassword);
passwordRoute.route("/delete/:passwordId").delete(deletePassword);
passwordRoute.route("/update/:passwordId").patch(updatePassword);
passwordRoute.route("/get-passwords/:userId").get(getAllUserPasswords);

export { passwordRoute };
