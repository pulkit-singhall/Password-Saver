import { asyncHandler } from "../utils/asyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { User } from "../models/user.model.js";
import { cookieOptions } from "../constants.js";

const generateTokens = async (user) => {
    try {
        const accessToken = await user.generateAccessToken();
        const refreshToken = await user.generateRefreshToken();

        user.refreshToken = refreshToken;
        await user.save({ validateBeforeSave: false });

        return {
            accessToken,
            refreshToken,
        };
    } catch (error) {
        throw new ApiError(500, "Error in token generation!");
    }
};

const registerUser = asyncHandler(async (req, res) => {
    const { email, fullname, password } = req.body;

    if (
        [email, fullname, password].some((field) => {
            // to prevent undefined
            if (!field) {
                return true;
            }
            if (field.trim() === "") {
                return true;
            }
        })
    ) {
        throw new ApiError(405, "All fields are required!");
    }

    const existedUser = await User.findOne({
        email: email, 
    });

    if (existedUser) {
        throw new ApiError(410, "User Already Exists!");
    }

    const user = await User.create({
        fullname: fullname,
        email: email,
        password: password,
    });

    const newUser = await User.findById(user._id).select(
        "-password -refreshToken -savedPasswords"
    );

    if (!newUser) {
        throw new ApiError(500, "User not registered!");
    }

    return res
        .status(201)
        .json(new ApiResponse(201, {newUser: newUser}, "Registeration Success"));
});

const loginUser = asyncHandler(async (req, res) => {
    const { email, password } = req.body;

    if (
        [email, password].some((field) => {
            if (!field) {
                return true;
            }
            if (field.trim() === "") {
                return true;
            }
        })
    ) {
        throw new ApiError(405, "All fields are required!");
    }

    const existedUser = await User.findOne({
        email: email,
    });

    if (!existedUser) {
        throw new ApiError(403, "Invalid User");
    }

    const passwordCheck = await existedUser.checkPassword(password);

    if (!passwordCheck) {
        throw new ApiError(412, "Wrong Password!");
    }

    const { accessToken, refreshToken } = await generateTokens(existedUser);

    const loggedInUser = await User.findById(existedUser._id).select(
        "-password -refreshToken -savedPasswords"
    );

    return res
        .status(202)
        .cookie("accessToken", accessToken, cookieOptions)
        .cookie("refreshToken", refreshToken, cookieOptions)
        .json(
            new ApiResponse(
                202,
                {
                    user: loggedInUser,
                    accessToken: accessToken,
                    refreshToken: refreshToken,
                },
                "Login Success!"
            )
        );
});

const logoutUser = asyncHandler(async (req, res) => {
    const user = req.user;

    if (!user) {
        throw new ApiError(405, "User not authorize to logout");
    }

    await User.findByIdAndUpdate(
        user._id,
        {
            $set: {
                refreshToken: "",
            },
        },
        {
            new: true,
        }
    );

    return res
        .status(201)
        .clearCookie("accessToken", cookieOptions)
        .clearCookie("refreshToken", cookieOptions)
        .json(new ApiResponse(201, {}, "Logged Out Success!"));
});

const getCurrentUser = asyncHandler(async (req, res) => {
    const user = req.user;
    const userId = user._id;

    const currentUser = await User.findById(userId);

    if (!currentUser) {
        throw new ApiError(
            500,
            "Internal server error in fetching current user"
        );
    }

    return res
        .status(200)
        .json(
            new ApiResponse(
                200,
                { currentUser: currentUser },
                "Current User fetched"
            )
        );
});

const changeUserPassword = asyncHandler(async (req, res) => {
    const { oldPassword, newPassword } = req.body;

    const user = await User.findById(req.user._id).select("-refreshToken");

    if (!user) {
        throw new ApiError(405, "User not authorize to change Password");
    }

    const passwordCheck = await user.checkPassword(oldPassword);

    if (!passwordCheck) {
        throw new ApiError(408, "Old Password is not correct");
    }

    // for bycrypting password
    user.password = newPassword;
    await user.save({ validateBeforeSave: false });

    return res.status(201).json(new ApiResponse(201, {}, "Password Changed"));
});

const updateUserAvatar = asyncHandler(async (req, res) => {});

const refreshTokens = asyncHandler(async (req, res) => {
    
});

export {
    registerUser,
    loginUser,
    getCurrentUser,
    refreshTokens,
    logoutUser,
    changeUserPassword,
    updateUserAvatar,
};
