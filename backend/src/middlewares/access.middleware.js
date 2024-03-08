import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const verifyAccess = async (req, res, next) => {
    try {
        const accessToken =
            req.cookies?.accessToken || req.headers.authorization?.split(" ")[1];
                
        if (!accessToken) {
            throw new ApiError(400, "Access Token Required");
        }

        const decodedToken = jwt.verify(
            accessToken,
            process.env.ACCESS_TOKEN_KEY,
        );

        if (!decodedToken) {
            // access token expired
            next();
        }

        return res.status(200).json(new ApiResponse(200, {}, "All Ok!"));
    } catch (error) {
        console.log(`Error in access token part: ${error}`);
        return res.json({
            error: error.message,
            statusCode: error.statusCode,
            success: error.success,
        });
    }
};

export { verifyAccess };
