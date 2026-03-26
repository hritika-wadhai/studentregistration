const app = require("./api/students");

const PORT = 3000;

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server running on http://10.206.86.78:${PORT}`);
});