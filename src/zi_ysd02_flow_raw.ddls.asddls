@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flow Connector Unique'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_YSD02_FLOW_RAW
  as select from I_SDDocumentMultiLevelProcFlow
{
  key PrecedingDocument             as SalesOrder,
  key PrecedingDocumentItem         as SalesOrderItem,
  key SubsequentDocument            as DocNum,
  key SubsequentDocumentItem        as DocItem,
      SubsequentDocumentCategory    as DocCat
}
where PrecedingDocumentCategory = 'C' -- Start from Sales Orders
  and ( SubsequentDocumentCategory = 'J' -- Delivery
     or SubsequentDocumentCategory = 'M' -- Invoice
     or SubsequentDocumentCategory = 'N' ) -- Invoice Cancellation
