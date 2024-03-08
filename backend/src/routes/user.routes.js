import express from "express";
import {
    registerUser,
    loginUser,
    getCurrentUser,
    logoutUser,
    changeUserPassword,
    updateUserAvatar,
} from "../controllers/user.controller.js";
import { verifyAccess } from "../middlewares/access.middleware.js";
import { verifyRefresh } from "../middlewares/refresh.miidleware.js";
import { verifyUser } from "../middlewares/auth.middleware.js";

const userRoute = express.Router();

userRoute.route("/current-user").get(verifyUser,getCurrentUser);
userRoute.route("/login").post(loginUser);
userRoute.route("/logout").post(verifyUser,logoutUser);
userRoute.route("/register").post(registerUser);
userRoute.route("/change-password").patch(verifyUser,changeUserPassword);
userRoute.route("/change-avatar").post(verifyUser,updateUserAvatar);
userRoute.route("/verify-user").post(verifyAccess, verifyRefresh);

export { userRoute };
