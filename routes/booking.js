const router = require("express").Router();
const Booking = require("../models/Booking");
const Seat = require("../models/Seat");

router.post("/", async (req, res) => {
  try {
    const {
      seats,
      firstName,
      lastName,
      email,
      phone,
      paymentMethod
    } = req.body;

    const takenSeats = await Seat.find({
      seatNumber: { $in: seats },
      isBooked: true
    });

    if (takenSeats.length > 0) {
      return res.status(400).json({
        message: "Some seats are already booked"
      });
    }

    // blloko seats
    await Seat.updateMany(
      { seatNumber: { $in: seats } },
      { isBooked: true }
    );

    let expiresAt = null;

    if (paymentMethod === "cash") {
      expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000);
    }

    const booking = await Booking.create({
      seats,
      firstName,
      lastName,
      email,
      phone,
      paymentMethod,
      expiresAt
    });

    res.json(booking);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
