const router = require("express").Router();
const Seat = require("../models/Seat");

router.get("/", async (req, res) => {
  try {
    const seats = await Seat.find();
    res.json(seats);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.post("/init", async (req, res) => {
  try {
    const seats = [];

    const rows = 4;
    const cols = 12;

    for (let r = 1; r <= rows; r++) {
      for (let c = 1; c <= cols; c++) {
        seats.push({
          seatNumber: `R${r}C${c}`,
          row: r,
          column: c
        });
      }
    }

    await Seat.insertMany(seats);
    res.json({ message: "Seats created" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
