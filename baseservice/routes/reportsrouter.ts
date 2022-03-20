import * as express from 'express';
import { Logger } from '../common'
import { ReportsController } from '../controllers'

const app = express();
const log = new Logger();

app.get("/provinces", (req, res,next) => {
    const result = ReportsController.getInstance().listArticles()
    .then((result) => {
        res.json({result:result});
    })
});

// Endpoint 01
app.post("/firstsdeliverables", (req, res) => {
    const result = ReportsController.getInstance().getFirstDeliverables(req.body)
    .then((result) => {
        res.json({result:result.recordsets});
    })
});
// Endpoint 02
app.post("/qualifyingthirds", (req, res) => {
    const result = ReportsController.getInstance().getQualifyingThirds(req.body.action_id)
    .then((result) => {
        res.json({result:result.recordsets});
    })
});

export { app as reportsrouter };