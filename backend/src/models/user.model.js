import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true,
    },
    fullname: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true,
    },
    avatar: {
        type: String,
    },
    avatarPublicId: {
        type: String,
    },
    refreshToken: {
        type: String,
    },
    savedPasswords: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Password",
        }
    ],
}, { timestamps: true });

export const User = mongoose.model("User", userSchema);