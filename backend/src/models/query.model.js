import mongoose from "mongoose";

const querySchema = new mongoose.Schema(
    {
        question: {
            type: String,
            required: true,
        },
        answer: {
            type: String,
            required: true,
        },
        externalPassword: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Password",
            required: true, 
        }
    },
    { timestamps: true }
);

export const Query = mongoose.model("Query", querySchema);