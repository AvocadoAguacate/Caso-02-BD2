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
app.post("/firstsDeliverables", (req, res) => {
    const result = ReportsController.getInstance().getFirstDeliverables(req.body)
    .then((result) => {
        res.json({result:result.recordsets});
    })
});
// Endpoint 02
app.post("/qualifyingThirds", (req, res) => {
    const result = ReportsController.getInstance().getQualifyingThirds(req.body.action_id)
    .then((result) => {
        res.json({result:result.recordsets});
    })
});

//Endpoint 03
app.post("/bestsMonthsDeliverys", (req, res) => {
    const result = ReportsController.getInstance().getbestsMonthsDeliverys(req.body)
    .then((result) => {
        res.json({result:result.recordsets});
    })
});

//Endpoint 04
app.post("/bestsDeliverysRepeatsSatisfaction", (req, res) => {
    const result = ReportsController.getInstance().getBestsDeliverysRepeatsSatisfaction(req.body)
    .then((result) => {
        res.json({result:result.recordsets});
    })
});

//Endpoint 05
app.post("/bestsDeliverysSatisfaction", (req, res) => {
    const result = ReportsController.getInstance().getBestsDeliverysSatisfaction(req.body)
    .then((result) => {
        res.json({result:result.recordsets});
    })
});

//Endpoint 06
app.post("/saveDeliverablesTrans", (req, res) => {
    const result = ReportsController.getInstance().getSaveDeliverablesTrans(req.body)
    .then((result) => {
        res.json({result:result.recordsets});
    })
});

export { app as reportsrouter };