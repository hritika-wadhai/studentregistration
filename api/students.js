const express = require("express");
const cors = require("cors");
const db = require("./db");

const sql = db.sql;
const config = db.config;

const app = express();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
    res.json({
        message: "Student Admission API",
        status: "running"
    });
});

app.post("/api/students", async (req, res) => {
    try {
        await sql.connect(config);
        const s = req.body;

        const result = await sql.query`
            INSERT INTO Students (
                first_name, middle_name, last_name, dob, age,
                blood_group, gender, address, religion, caste,
                mother_tongue, aadhar, state, city, pincode,
                applying_class, previous_school,
                father_name, father_occupation,
                mother_name, mother_occupation,
                father_contact, mother_contact, emergency_contact
            )
            OUTPUT INSERTED.student_id
            VALUES (
                ${s.first_name}, ${s.middle_name || null}, ${s.last_name},
                ${s.dob}, ${s.age},
                ${s.blood_group}, ${s.gender}, ${s.address},
                ${s.religion}, ${s.caste}, ${s.mother_tongue},
                ${s.aadhar}, ${s.state}, ${s.city}, ${s.pincode},
                ${s.applying_class}, ${s.previous_school},
                ${s.father_name}, ${s.father_occupation},
                ${s.mother_name}, ${s.mother_occupation},
                ${s.father_contact}, ${s.mother_contact}, ${s.emergency_contact}
            )
        `;

        const studentId = result.recordset[0].student_id;

        if (Array.isArray(s.exams)) {
            for (let exam of s.exams) {
                await sql.query`
                    INSERT INTO Student_Exams (student_id, exam_id)
                    VALUES (${studentId}, ${exam})
                `;
            }
        }

        res.json({
            success: true,
            message: "Student added successfully"
        });

    } catch (err) {
        console.error(err);
        res.status(500).json({ success:false, error:err.message });
    }
});

app.get("/api/students", async (req, res) => {
    try {
        await sql.connect(config);

        const result = await sql.query`
            SELECT
                s.student_id,
                CONCAT(s.first_name,' ',COALESCE(s.middle_name+' ',''),s.last_name) AS name,
                s.applying_class,
                s.city,
                s.father_name,
                s.father_contact,
                COALESCE(STRING_AGG(e.exam_name, ', '), 'None') AS exams
            FROM Students s
            LEFT JOIN Student_Exams se ON s.student_id = se.student_id
            LEFT JOIN Exams_appeared e ON se.exam_id = e.exam_id
            GROUP BY
                s.student_id,
                s.first_name,
                s.middle_name,
                s.last_name,
                s.applying_class,
                s.city,
                s.father_name,
                s.father_contact
            ORDER BY s.student_id DESC
        `;

        res.json({
            success:true,
            students:result.recordset
        });

    } catch (err) {
        res.status(500).json({ success:false,error:err.message });
    }
});

module.exports = app;