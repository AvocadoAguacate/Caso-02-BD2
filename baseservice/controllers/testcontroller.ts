import { Console } from 'console';
import { Logger } from '../common'
const sql = require('mssql')
const sqlConfig = {
  user: "sa",
  password: "pass123",
  server: "localhost",
  database: "Caso02_DB2_Esteban_David",
  pool: {
    max: 10,
    min: 0,
    idleTimeoutMillis: 30000
  },
  trustServerCertificate: true
}

export class TestController {
    private static instance: TestController;
    private log: Logger;
    private constructor()
    {
        this.log = new Logger();
        try
        {
        } catch (e)
        {
            this.log.error(e);
        }
    }

    public static getInstance() : TestController
    {
        if (!this.instance)
        {
            this.instance = new TestController();
        }
        return this.instance;
    }

    public listArticles() : Promise<any> 
    {
      const promise = new Promise( async (resolve, reject) => {
        try {
         // make sure that any items are correctly URL encoded in the connection string
         await sql.connect(sqlConfig);
         const result = await sql.query`select * from PROVINCE`;
         //console.dir(result.recordset);
         console.log(result.recordset);
         resolve(result.recordset);
        } catch (err) {
         reject(err)
        }
       })
        return promise;
    }
}