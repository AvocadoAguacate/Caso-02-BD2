import { Connection } from 'mssql';
import { resolve } from 'path';
import { Logger } from '../common'
import { AdminPool } from './adminpool';
const sql = require("mssql");
var Request = require('tedious').Request;

export class data_reports {
    private log: Logger;
    private connection: any;
    public constructor()
    {
      // via singleton, accediendo a un solo pool tengo una conexiona la base de datos
      this.connection = AdminPool.getConnection();
    }

    public getAllProvinces() : Promise<any>
    {
        const promise = new Promise((resolve, reject) => {
          try{
            this.connection.then( (pool) => {
              resolve(pool.query`select * from PROVINCE`);
            })
          } catch(err){
            reject(err);
          }
        })
        return promise;
    }

    public getFirstDeliverables(action_id : number) : Promise<any>
    {
        const promise = new Promise((resolve, reject) => {
          try{
            this.connection.then( (pool) => {
              resolve(
                pool.request()
                .input('action_id', sql.Int, action_id)
                .execute('endpoint02')
              );
            })
          } catch(err){
            reject(err);
          }
        })
        return promise;
    }

}