import { asyncHandler } from "../utils/asyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";

const generateTokens = async (user) => {} 

const registerUser = asyncHandler(async (req, res) => { });

const loginUser = asyncHandler(async (req, res) => { });

const logoutUser = asyncHandler(async (req, res) => { });

const getCurrentUser = asyncHandler(async (req, res) => {
    
});

const changeUserPassword = asyncHandler(async (req, res) => { });

const updateUserAvatar = asyncHandler(async (req, res) => { });

const refreshTokens = asyncHandler(async (req, res) => { });

export {
    registerUser,
    loginUser,
    getCurrentUser,
    refreshTokens,
    logoutUser,
    changeUserPassword,
    updateUserAvatar,
};