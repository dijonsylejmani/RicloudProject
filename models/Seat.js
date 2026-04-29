const mongoose = require("mongoose");

const seatSchema = new mongoose.Schema({
  seatNumber: String,
  row: Number,
  column: Number,
  isBooked: {
    type: Boolean,
    default: false
  }
});

module.exports = mongoose.model("Seat", seatSchema);
