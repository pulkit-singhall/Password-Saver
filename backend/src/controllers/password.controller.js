import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { User } from "../models/user.model.js";
import mongoose from "mongoose";
import { Password } from "../models/password.model.js";
import Cryptr from "cryptr";
import dotenv from "dotenv";

dotenv.config();

const cryptr = new Cryptr(`${process.env.CRYPTR_SECRET_KEY}`);

const createPassword = async (req, res) => {
    try {
        const { title, description, value, pin } = req.body;
        const user = req.user;

        if (
            [title, value].some((field) => {
                if (!field) {
                    return true;
                }
                if (field.trim() === "") {
                    return true;
                }
            })
        ) {
            throw new ApiError(400, "Fields are required");
        }

        const userId = user._id;
        const existingPassword = await User.aggregate([
            {
                $match: {
                    _id: new mongoose.Types.ObjectId(userId),
                },
            },
            {
                $lookup: {
                    from: "passwords",
                    localField: "_id",
                    foreignField: "owner",
                    as: "userPasswords",
                    pipeline: [
                        {
                            $match: {
                                title: title,
                            },
                        },
                    ],
                },
            },
            {
                $project: {
                    userPasswords: 1,
                },
            },
        ]);

        if (!existingPassword || existingPassword.length === 0) {
            throw new ApiError(402, "Wrong User ID");
        }

        if (existingPassword[0].userPasswords.length > 0) {
            throw new ApiError(404, "Password with same title already exists");
        }

        const password = await Password.create({
            title: title,
            description: description,
            value: value,
            pin: pin,
            owner: userId,
        });

        if (!password) {
            throw new ApiError(500, "Internal server error in saving password");
        }

        const encryptedValue = password.value;
        const decryptedValue = cryptr.decrypt(encryptedValue);
        password.value = decryptedValue;

        const encryptedPin = password.pin;
        let decryptedPin = "";
        if (encryptedPin.length > 0) {
            decryptedPin = cryptr.decrypt(encryptedPin);
        }
        password.pin = decryptedPin;

        const passwordId = password._id;
        const userToChange = await User.findById(userId);
        userToChange.savedPasswords.push(passwordId);
        await userToChange.save({ validateBeforeSave: false });

        return res
            .status(201)
            .json(
                new ApiResponse(
                    201,
                    { createdPassword: password },
                    "New Password Saved"
                )
            );
    } catch (error) {
        return res.json({
            success: error.success,
            error: error.message,
            statusCode: error.statusCode,
        });
    }
};

const deletePassword = async (req, res) => {
    try {
        const { passwordId } = req.params;
        const user = req.user;
    
        if (!passwordId || passwordId.trim() === "") {
            throw new ApiError(400, "Password ID is required");
        }
    
        const password = await Password.findById(passwordId);
        if (!password) {
            throw new ApiError(402, "Wrong Password ID");
        }
    
        const owner = password.owner;
    
        if (!user._id.equals(owner)) {
            throw new ApiError(406, "User cant delete this password");
        }
    
        const deletedPassword = await Password.findByIdAndDelete(passwordId);
        if (!deletePassword) {
            throw new ApiError(500, "Internal server error in deleting password");
        }

        const userToChange = await User.findById(user._id);
        const savedPasswords = userToChange.savedPasswords;
        const index = savedPasswords.indexOf(passwordId);
        savedPasswords.splice(index, 1);
        userToChange.savedPasswords = savedPasswords;
        await userToChange.save({ validateBeforeSave: false });
    
        return res
            .status(200)
            .json(
                new ApiResponse(
                    200,
                    { deletedPassword: deletedPassword },
                    "Password Deleted"
                )
            );
    } catch (error) {
        return res.json({
            success: error.success,
            error: error.message,
            statusCode: error.statusCode,
        });
    }
};

const updatePassword = async (req, res) => {
    const { passwordId } = req.params;
    const user = req.user;

    if (!passwordId || passwordId.trim() === "") {
        throw new ApiError(400, "Password ID is required");
    }

    const password = await Password.findById(passwordId);
    if (!password) {
        throw new ApiError(402, "Wrong Password ID");
    }

    const owner = password.owner;

    if (!user._id.equals(owner)) {
        throw new ApiError(406, "User cant update this password");
    }
};

const getAllUserPasswords = async (req, res) => {
    try {
        const user = req.user;
        const userId = user._id;
    
        const passwords = await User.aggregate([
            {
                $match: {
                    _id: new mongoose.Types.ObjectId(userId),
                },
            },
            {
                $lookup: {
                    from: "passwords",
                    localField: "_id",
                    foreignField: "owner",
                    as: "userPasswords",
                },
            },
            {
                $project: {
                    userPasswords: 1,
                },
            },
        ]);
    
        if (!passwords || passwords.length === 0) {
            throw new ApiError(
                500,
                "Internal server error in fetching user passwords"
            );
        }
    
        const userPasswords = passwords[0].userPasswords;
    
        return res
            .status(200)
            .json(
                new ApiResponse(
                    200,
                    { userPasswords: userPasswords },
                    "User Passwords Fetched"
                )
            );
    } catch (error) {
        return res.json({
            success: error.success,
            error: error.message,
            statusCode: error.statusCode,
        });
    }
};

export { createPassword, deletePassword, updatePassword, getAllUserPasswords };
