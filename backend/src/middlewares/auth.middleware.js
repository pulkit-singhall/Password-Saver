import jwt from "jsonwebtoken";
import { ApiError } from "../utils/ApiError.js";
import dotenv from "dotenv";
import { User } from "../models/user.model.js";

dotenv.config();

const verifyUser = async (req, res, next) => {
    try {
        const token =
            req.cookies?.accessToken ||
            req.headers.authorization?.split(" ")[1]; // for mobile apps

        if (!token) {
            throw new ApiError(400, "Access Token Required");
        }

        // returns payload
        const decodedToken = jwt.verify(token, process.env.ACCESS_TOKEN_KEY);

        if (!decodedToken) {
            throw new ApiError(405, "Expired Token");
        }

        const user = await User.findById(decodedToken._id).select(
            "-password -refreshToken -savedPasswords"
        );

        if (!user) {
            throw new ApiError(405, "Invalid Token for User");
        }

        req.user = user;
        next();
    } catch (error) {
        console.log(`Error in auth middleware part: ${error}`);
        return res.json({
            error: error.message,
            statusCode: error.statusCode,
            success: error.success,
        });
    }
};

export { verifyUser };
