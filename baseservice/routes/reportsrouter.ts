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

export { app as reportsrouter };