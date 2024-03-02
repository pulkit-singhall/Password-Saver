import mongoose from "mongoose";
import Cryptr from "cryptr";
import dotenv from "dotenv";

dotenv.config();

const cryptr = new Cryptr(`${process.env.CRYPTR_SECRET_KEY}`);

const passwordSchema = new mongoose.Schema(
    {
        title: {
            type: String,
            required: true,
        },
        description: {
            type: String,
        },
        value: {
            type: String,
            required: true,
        },
        pin: {
            type: String,
        },
        owner: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User",
        },
        referenceQueries: [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Query",
            },
        ],
    },
    { timestamps: true }
);

passwordSchema.pre("save", async function (next) {
    if (this.isModified("value")) {
        this.value = cryptr.encrypt(this.value);
    }
    if (this.isModified("pin")) {
        this.pin = cryptr.encrypt(this.pin);
    }
    next();
});

export const Password = mongoose.model("Password", passwordSchema);