import * as express from 'express';
import { Logger } from '../common'
import { TestController } from '../controllers'

const app = express();
const log = new Logger();

app.get("/list", (req, res,next) => {
    const result = TestController.getInstance().listArticles()
    .then((result) => {
        res.json({result:result});
    })
    // console.log(result);
    // res.json({kind : 'hi!'});
    // TestController.getInstance().listArticles(); 
});

export { app as testrouter };