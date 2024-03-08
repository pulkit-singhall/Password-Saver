import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import { User } from "../models/user.model.js";

dotenv.config();

const verifyRefresh = async (req, res) => {
    try {
        const { refreshToken } = req.body;
    
        if (!refreshToken) {
            throw new ApiError(400, "Refresh token required");
        }
    
        const decodedToken = jwt.verify(
            refreshToken,
            process.env.REFRESH_TOKEN_KEY
        );
    
        if (!decodedToken) {
            // refresh token expired
            throw new ApiError(405, "Refresh Token Expired"); // again user has to login
        }
    
        // refresh both the tokens
        const userId = decodedToken._id;
        const user = await User.findById(userId);

        if (user.refreshToken !== refreshToken) {
            throw new ApiError(405, "Refresh Token doesnt match");
        }
    
        const newAccessToken = await user.generateAccessToken();
        const newRefreshToken = await user.generateRefreshToken();
    
        user.refreshToken = newRefreshToken;
        await user.save({ validateBeforeSave: false });
    
        return res
            .status(201)
            .json(
                new ApiResponse(
                    201,
                    {
                        newAccessToken: newAccessToken,
                        newRefreshToken: newRefreshToken,
                    },
                    "Tokens Refreshed"
                )
            );
    } catch (error) {
        console.log(`Error in refresh token part: ${error}`);
        return res.json({
            error: error.message,
            statusCode: error.statusCode,
            success: error.success,
        });
    }
};

export { verifyRefresh };
