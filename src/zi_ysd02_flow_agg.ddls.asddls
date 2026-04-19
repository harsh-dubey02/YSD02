@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flow Aggregation (Summed)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_YSD02_FLOW_AGG
  as select from ZI_YSD02_FLOW_RAW as Flow
    /* 1. Use STANDARD Delivery View */
    left outer join I_DeliveryDocumentItem as Deliv 
      on  Deliv.DeliveryDocument     = Flow.DocNum
      and Deliv.DeliveryDocumentItem = Flow.DocItem
      and Flow.DocCat = 'J'
    /* 2. Use BASIC Billing View */
    left outer join I_BillingDocumentItemBasic as Inv
      on  Inv.BillingDocument     = Flow.DocNum
      and Inv.BillingDocumentItem = Flow.DocItem
      and ( Flow.DocCat = 'M' or Flow.DocCat = 'N' )
{
  key Flow.SalesOrder,
  key Flow.SalesOrderItem,

      /* TOTAL DELIVERED QTY */
      @Semantics.quantity.unitOfMeasure: 'DeliveryUnit'
      cast( sum( case when Flow.DocCat = 'J' 
                 then Deliv.ActualDeliveryQuantity 
                 else 0 end ) as abap.quan( 13, 3 ) ) as TotalDeliveredQty,

      /* TOTAL INVOICED QTY */
      @Semantics.quantity.unitOfMeasure: 'InvoiceUnit'
      cast( sum( case when Flow.DocCat = 'M' 
                      then Inv.BillingQuantity
                      when Flow.DocCat = 'N'
                      then ( Inv.BillingQuantity * -1 )
                      else 0 end ) as abap.quan( 13, 3 ) ) as TotalInvoicedQty,

      /* NEW: BATCH FROM DELIVERY */
      /* Picks the batch from the delivery line. Max ensures we get a value if multiple exist. */
      cast( max( case when Flow.DocCat = 'J' then Deliv.Batch 
           else '' end ) as abap.char(10) ) as Batch,

      /* LAST DELIVERY DATE */
      max( case when Flow.DocCat = 'J' then Deliv.CreationDate 
           else '00000000' end ) as LastDeliveryDate,

      /* DOCUMENT NUMBERS */
      max( case when Flow.DocCat = 'J' then Flow.DocNum else '' end ) as LatestDeliveryDoc,
      max( case when Flow.DocCat = 'M' then Flow.DocNum else '' end ) as LatestInvoiceDoc,

      /* UNITS */
      cast( max( case when Flow.DocCat = 'J' then Deliv.DeliveryQuantityUnit 
           else '' end ) as abap.unit(3) ) as DeliveryUnit,

      cast( max( case when ( Flow.DocCat = 'M' or Flow.DocCat = 'N' ) then Inv.BillingQuantityUnit 
           else '' end ) as abap.unit(3) ) as InvoiceUnit
}
group by
  Flow.SalesOrder,
  Flow.SalesOrderItem
