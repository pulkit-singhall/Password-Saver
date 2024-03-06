import express from "express";
import {
    registerUser,
    loginUser,
    getCurrentUser,
    refreshTokens,
    logoutUser,
    changeUserPassword,
    updateUserAvatar,
} from "../controllers/user.controller.js";

const userRoute = express.Router();

userRoute.route("/current-user").get(getCurrentUser);
userRoute.route("/login").post(loginUser);
userRoute.route("/logout").post(logoutUser);
userRoute.route("/register").post(registerUser);
userRoute.route("/change-password").patch(changeUserPassword);
userRoute.route("/change-avatar").post(updateUserAvatar);


export { userRoute };
