require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");

const app = express();
app.use(express.json());

mongoose.connect("mongodb://127.0.0.1:27017/bus_app")
  .then(() => console.log("MongoDB connected"))
  .catch(err => console.log(err));

app.use("/api/seats", require("./routes/seats"));
app.use("/api/booking", require("./routes/booking"));

app.listen(5000, () => {
  console.log("Server running on port 5000");
});
