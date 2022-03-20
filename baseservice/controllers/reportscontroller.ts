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
          const dynamo = new data_reports();
          resolve(dynamo.getAllProvinces());
        } catch (err) {
         reject(err);
        }
       });
        return promise;
    }

    // endpoint 01

    public getFirstDeliverables(body: any) : Promise<any>
    {
        let party_id: number = body.party_id  == undefined ? null : body.party_id;
        let canton_id: number = body.canton_id == undefined ? null : body.party_id;
        let first_day: string = body.first_day;
        let last_day: string = body.last_day;

        const promise = new Promise( (resolve, reject) => {
            try {
                const dynamo = new data_reports();
                resolve(dynamo.getFirstDeliverables(party_id, canton_id, first_day, last_day));
            } catch (err) {
                reject(err);
            }
        });
        return promise;
    }

    // endpoint 02
    
    public getQualifyingThirds(action_id: number) : Promise<any>
    {
        const promise = new Promise( (resolve, reject) => {
            try {
                const dynamo = new data_reports();
                resolve(dynamo.getQualifyingThirds(action_id));
            } catch (err) {
                reject(err);
            }
        });
        return promise;
    }

    // endpoint 03
    
    public getbestsMonthsDeliverys(body: any) : Promise<any>
    {
        let party_id: number = body.party_id  == undefined ? null : body.party_id;
        let text: string = body.text;

        const promise = new Promise( (resolve, reject) => {
            try {
                const dynamo = new data_reports();
                resolve(dynamo.getbestsMonthsDeliverys(party_id, text));
            } catch (err) {
                reject(err);
            }
        });
        return promise;
    }

    // endpoint 04
    
    public getBestsDeliverysRepeatsSatisfaction(body: any) : Promise<any>
    {
        let party_id: number = body.party_id  == undefined ? null : body.party_id;
        let first_day: string = body.first_day;
        let last_day: string = body.last_day;

        const promise = new Promise( (resolve, reject) => {
            try {
                const dynamo = new data_reports();
                resolve(dynamo.getBestsDeliverysRepeatsSatisfaction(party_id, first_day, last_day));
            } catch (err) {
                reject(err);
            }
        });
        return promise;
    }

    // endpoint 05
    
    public getBestsDeliverysSatisfaction(body: any) : Promise<any>
    {
        let party_id: number = body.party_id  == undefined ? null : body.party_id;
        let first_day: string = body.first_day;
        let last_day: string = body.last_day;

        const promise = new Promise( (resolve, reject) => {
            try {
                const dynamo = new data_reports();
                resolve(dynamo.getBestsDeliverysSatisfaction(party_id, first_day, last_day));
            } catch (err) {
                reject(err);
            }
        });
        return promise;
    }

    // endpoint 06
    
    public getPersonalDeliverables(body: any) : Promise<any>
    {
        let person_id: number = body.person_id;
        let plan_id: number = body.plan_id;

        const promise = new Promise( (resolve, reject) => {
            try {
                const dynamo = new data_reports();
                resolve(dynamo.getPersonalDeliverables(person_id, plan_id));
            } catch (err) {
                reject(err);
            }
        });
        return promise;
    }
}