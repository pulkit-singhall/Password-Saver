import { asyncHandler } from "../utils/asyncHandler.js";
import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { Query } from "../models/query.model.js";
import { Password } from "../models/password.model.js";
import mongoose from "mongoose";

const createQuery = asyncHandler(async (req, res) => {
    const { answer, question } = req.body;
    const { passwordId } = req.params;

    if (
        [answer, question].some((field) => {
            if (!field) {
                return true;
            }
            if (field.trim() === "") {
                return true;
            }
        })
    ) {
        throw new ApiError(400, "Fields are required!");
    }

    const createdQuery = await Query.create({
        question: question,
        answer: answer,
        externalPassword: passwordId,
    });

    if (!createdQuery) {
        throw new ApiError(500, "Internal server error in creating the query");
    }

    return res
        .status(201)
        .json(
            new ApiResponse(
                201,
                { createdQuery: createdQuery },
                "Query created"
            )
        );
});

const updateQuery = asyncHandler(async (req, res) => {
    
});

const deleteQuery = asyncHandler(async (req, res) => {
    const { queryId } = req.params;

    if (!queryId || queryId.trim() === "") {
        throw new ApiError(400, "Query ID is required");
    }

    const deletedQuery = await Query.findByIdAndDelete(queryId);

    if (!deletedQuery) {
        throw new ApiError(500, "Internal error in deleting the query");
    }

    return res.status(200).json(new ApiResponse(200, {}, "Query deleted"));
});

const getPasswordQueries = asyncHandler(async (req, res) => {
    const { passwordId } = req.params;

    const queries = await Password.aggregate([
        {
            $match: {
                _id: new mongoose.Types.ObjectId(passwordId),
            },
        },
        {
            $lookup: {
                from: "queries",
                localField: "_id",
                foreignField: "externalPassword",
                as: "passwordQueries",
            },
        },
        {
            $project: {
                passwordQueries: 1,
            },
        },
    ]);

    if (!queries || queries.length === 0) {
        throw new ApiError(500, "Internal error in fetching queries");
    }

    return res
        .status(200)
        .json(
            new ApiResponse(
                200,
                { passwordQueries: queries[0].passwordQueries },
                "Password Queries fetched"
            )
        );
});

export { createQuery, updateQuery, deleteQuery, getPasswordQueries };
