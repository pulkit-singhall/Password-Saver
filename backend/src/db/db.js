import mongoose from "mongoose";
import dotenv from "dotenv";
import { DB_NAME } from "../constants.js";

dotenv.config();

const connectDB = new Promise((resolve, reject) => {
    try {
        const connection = mongoose.connect(
            `${process.env.MONGO_DB_URI}/${DB_NAME}`
        );
        resolve(connection);
    }
    catch (error) {
        reject(error);
    }
});

export default connectDB;