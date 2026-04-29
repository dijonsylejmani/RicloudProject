const mongoose = require("mongoose");

const bookingSchema = new mongoose.Schema({
  seats: [String],

  firstName: String,
  lastName: String,
  email: String,
  phone: String,

  paymentMethod: {
    type: String,
    enum: ["card", "cash"]
  },

  status: {
    type: String,
    enum: ["pending", "paid", "expired"],
    default: "pending"
  },

  expiresAt: Date,

  createdAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model("Booking", bookingSchema);
