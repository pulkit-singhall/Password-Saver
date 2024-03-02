import mongoose from "mongoose";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import bcrypt from "bcrypt";

dotenv.config();

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

userSchema.methods.checkPassword = async function (incomingPassword) {
    return await bcrypt.compare(incomingPassword, this.password);
}

userSchema.methods.generateAccessToken = function () {
    return jwt.sign(
        {
            _id: this._id,
            email: this.email,
            fullname: this.fullname,
        },
        process.env.ACCESS_TOKEN_KEY,
        {
            expiresIn: process.env.ACCESS_TOKEN_EXPIRY,
        }
    );
}

userSchema.methods.generateRefreshToken = function () {
    return jwt.sign(
        {
            _id: this._id,
        },
        process.env.REFRESH_TOKEN_KEY,
        {
            expiresIn: process.env.REFRESH_TOKEN_EXPIRY,
        }
    );
}

userSchema.pre("save", async function (next) {
    // for this keyword
    if (this.isModified("password")) {
        this.password = await bcrypt.hash(this.password, 5);
    }
    next();
});

export const User = mongoose.model("User", userSchema);