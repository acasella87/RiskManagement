/* 
 * namespace permette di usare nomi senza specificarli completamente 
 * (è un prefisso automatico aggiunto a ogni nome) 
 */
namespace riskmanagement;
 using { managed } from '@sap/cds/common';

 /* 
  * l'utilizzo di managed permette di aggiungere automaticamente i campi
  * createdAt
  * createdBy
  * modifiedAt
  * modifiedBy 
  */
 entity Risks : managed {
 /* 
  * chiave automaticamente riempita da CAP, 
  * esposta all'utente del servizio mediante la notazione @(Core.Computed : true) 
  */
 key ID : UUID @(Core.Computed : true); 
 title : String(100);
 owner : String;
 prio : String(5);
 descr : String;
 /* ogni Risk ha un'associazione con esattamente una Mitigation */
 miti : Association to Mitigations;
 impact : Integer;
 bp : Association to BusinessPartners;
 // You will need this definition in a later step
 criticality : Integer;
 }

 entity Mitigations : managed {
 key ID : UUID @(Core.Computed : true);
 descr : String;
 owner : String;
 timeline : String;
 /* una Mitigation può essere usata per più Risk */
 risks : Association to many Risks on risks.miti = $self;
 }

// using an external service from S/4
using { API_BUSINESS_PARTNER as external } from '../srv/external/API_BUSINESS_PARTNER.csn';

entity BusinessPartners as projection on external.A_BusinessPartner {
    key BusinessPartner,
    LastName,
    FirstName
}