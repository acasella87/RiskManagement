/*
 * creazione nuovo servizio RiskService nel namespace riskmanagement
 */
using { riskmanagement as rm } from '../db/schema';

 /*
  * il servizio è esposto tramite URL service/risk
  */
 @path: 'service/risk'
 service RiskService {
 /*
  * semplice esposizione della entity creata in schema.cds
  */
 entity Risks @(restict : [
     {
         grant : [ 'READ' ],
         to : [ 'RiskViewer' ]
     },
     {
         grant : [ '*' ],
         to : [ 'RiskManager' ]
     }
 ]) as projection on rm.Risks;
     /*
      * abilita sessione di edit con draft state:
      * l'utente può interrompere e riprendere dopo la sessione di modifica
      */
     annotate Risks with @odata.draft.enabled;
 entity Mitigations @(restict : [
     {
         grant : [ 'READ' ],
         to : [ 'RiskViewer' ]
     },
     {
         grant : [ '*' ],
         to : [ 'RiskManager' ]
     }
 ]) as projection on rm.Mitigations;
     annotate Mitigations with @odata.draft.enabled;
 entity BusinessPartners as projection on rm.BusinessPartners;
 }
 