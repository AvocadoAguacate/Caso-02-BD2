import { Logger } from '../common'
import { AdminPool } from '../repositories/adminpool';
import { data_reports } from '../repositories/data_reports';

export class ReportsController {
    private static instance: ReportsController;
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

    public static getInstance() : ReportsController
    {
        if (!this.instance)
        {
            this.instance = new ReportsController();
        }
        return this.instance;
    }

    public listArticles() : Promise<any> 
    {
      const promise = new Promise( async (resolve, reject) => {
        try {
          const dynamo = new data_reports()
          resolve(dynamo.getAllProvinces());
        } catch (err) {
         reject(err)
        }
       })
        return promise;
    }
}