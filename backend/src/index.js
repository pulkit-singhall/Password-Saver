import app from "./app.js";
import connectDB from "./db/db.js";
import dotenv from "dotenv";

dotenv.config();

connectDB
    .then((connectionObject) => {
        console.log("Database connected");
        app.listen(process.env.PORT || 3000, () => {
            console.log(`Server running at ${process.env.PORT}`);
        });
    })
    .catch((error) => {
        console.log(`Error in connecting to database: ${error}`);
    });
