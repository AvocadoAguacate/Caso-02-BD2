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

    // endpoint 01

    public getFirstDeliverables(party_id: number, canton_id: number, first_day: string, last_day: string) : Promise<any>
    {
        const promise = new Promise((resolve, reject) => {
          try{
            this.connection.then( (pool) => {
              resolve(
                pool.request()
                .input('party_id', sql.Int, party_id)
                .input('canton_id', sql.Int, canton_id)
                .input('first_day', sql.Date, first_day)
                .input('last_day', sql.Date, last_day)
                .execute('endpoint01')
              );
            })
          } catch(err){
            reject(err);
          }
        })
        return promise;
    }

    // endpoint 02

    public getQualifyingThirds(action_id : number) : Promise<any>
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