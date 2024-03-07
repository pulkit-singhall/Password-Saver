import { ApiError } from "../utils/ApiError.js";
import { ApiResponse } from "../utils/ApiResponse.js";
import { Query } from "../models/query.model.js";
import { Password } from "../models/password.model.js";
import mongoose from "mongoose";

const createQuery = async (req, res) => {
    try {
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

        const password = await Password.findById(passwordId);
        password.referenceQueries.push(createdQuery._id);
        await password.save({ validateBeforeSave: false });
    
        return res
            .status(201)
            .json(
                new ApiResponse(
                    201,
                    { createdQuery: createdQuery },
                    "Query created"
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

const updateQuery = async (req, res) => {
    try {
        const { queryId } = req.params;
        const { answer, question } = req.body;
    
        const query = await Query.findById(queryId);
    
        if (!query) {
            throw new ApiError(402, "Wrong Query ID");
        }
    
        const oldAnswer = query.answer;
        const oldQuestion = query.question;
    
        if (answer) {
            oldAnswer = answer;
        }
        if (question) {
            oldQuestion = question;
        }
    
        const updatedQuery = await Query.findByIdAndUpdate(
            queryId,
            {
                $set: {
                    answer: oldAnswer,
                    question: oldQuestion,
                },
            },
            {
                new: true,
            }
        );
    
        if (!updatedQuery) {
            throw new ApiError(500, "Internal server error in updating the query");
        }
    
        return res
            .status(200)
            .json(
                new ApiResponse(
                    200,
                    { updatedQuery: updatedQuery },
                    "Query Updated"
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

const deleteQuery = async (req, res) => {
    try {
        const { queryId } = req.params;
    
        if (!queryId || queryId.trim() === "") {
            throw new ApiError(400, "Query ID is required");
        }
    
        const deletedQuery = await Query.findByIdAndDelete(queryId);
    
        if (!deletedQuery) {
            throw new ApiError(500, "Internal error in deleting the query");
        }
    
        const extPassword = deletedQuery.externalPassword;
        const password = await Password.findById(extPassword);
        const refQueries = password.referenceQueries;
        const index = refQueries.indexOf(queryId);
        refQueries.splice(index, 1);
        password.referenceQueries = refQueries;
        await password.save({ validateBeforeSave: false});
    
        return res.status(200).json(new ApiResponse(200, {}, "Query deleted"));
    } catch (error) {
        return res.json({
            success: error.success,
            error: error.message,
            statusCode: error.statusCode,
        });
    }
};

const getPasswordQueries = async (req, res) => {
    try {
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
    } catch (error) {
        return res.json({
            success: error.success,
            error: error.message,
            statusCode: error.statusCode,
        });
    }
};

export { createQuery, updateQuery, deleteQuery, getPasswordQueries };
