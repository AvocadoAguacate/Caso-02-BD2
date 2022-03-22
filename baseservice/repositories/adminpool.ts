const sql = require("mssql");
import { Connection, ConnectionPool } from 'mssql';
import { resolve } from 'path';
import { Logger } from '../common'

const sqlConfig = {
  user: "sa",
  password: "123",
  server: "25.77.226.95",
  database: "Caso02_DB2_Esteban_David",
  pool: {
    max: 10,
    min: 0,
    idleTimeoutMillis: 30000,
  },
  trustServerCertificate: true,
};

const pool = new sql.ConnectionPool(sqlConfig);

export class AdminPool {
  private static instance: AdminPool;
  private log: Logger;
  private pool: ConnectionPool;
  private sqlConfig: Object = 
  {
    user: "sa",
    password: "123",
    server: "25.77.226.95",
    database: "Caso02_DB2_Esteban_David",
    pool: {
      max: 10,
      min: 0,
      idleTimeoutMillis: 30000,
    },
    trustServerCertificate: true,
  };

  private constructor()
  {
    this.log = new Logger();
    try{
      this.pool = new sql.ConnectionPool(this.sqlConfig);

    }catch(e){
      this.log.error(e);
    }
  }

  private static getInstance() : AdminPool
  {
    if(!this.instance){
      this.instance = new AdminPool();
    }
    return this.instance;
  }
  public static getConnection() : Promise<any>
  {
    const connection = new Promise((resolve, rejects) => {
      this.getInstance().pool.connect()
      .then((pool) => {
        resolve(pool)
      }).catch(err => {
        rejects(err)
      })
    })
    return connection;
  }
}
