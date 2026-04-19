@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YSD02 - Sales Full Custom Report'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true 
@UI.headerInfo: {
  typeName: 'Sales Report',
  typeNamePlural: 'Sales Reports'
}
define root view entity ZI_YSD02
  as select from    I_SalesOrderItem as Item
    inner join      I_SalesOrder     as Head on Head.SalesOrder = Item.SalesOrder
    
    /* JOIN TO AGGREGATION (Flow Data) */
    left outer join ZI_YSD02_FLOW_AGG as Flow on  Flow.SalesOrder     = Item.SalesOrder
                                              and Flow.SalesOrderItem = Item.SalesOrderItem
                                              
    left outer join I_SalesOrganizationText as OrgText on OrgText.SalesOrganization = Head.SalesOrganization
                                                      and OrgText.Language          = $session.system_language                                          
    
    /* NEW: Plant Description */
    left outer join I_Plant                 as Plant   on Plant.Plant = Item.Plant

    /* Product Description */
    left outer join I_ProductText    as Mat  on  Mat.Product  = Item.Product
                                             and Mat.Language = $session.system_language
    
    /* Bill-To Party (Partner Function 'RE') */
    left outer join I_SalesOrderPartner     as BillTo  on BillTo.SalesOrder      = Head.SalesOrder
                                                      and BillTo.PartnerFunction = 'RE'

    /* Ship-To Party (Partner Function 'WE') */
    left outer join I_SalesOrderPartner     as ShipTo  on ShipTo.SalesOrder      = Head.SalesOrder
                                                      and ShipTo.PartnerFunction = 'WE'
    
    /* Sales Office Description */
    left outer join I_SalesOfficeText as OfficeText on OfficeText.SalesOffice = Head.SalesOffice
                                                   and OfficeText.Language    = $session.system_language
    
    /* Sales Group Description */
    left outer join I_SalesGroupText as GroupText   on GroupText.SalesGroup   = Head.SalesGroup
                                                   and GroupText.Language     = $session.system_language

    /* Distribution Channel Description */
    left outer join I_DistributionChannelText as DistText on DistText.DistributionChannel = Head.DistributionChannel
                                                         and DistText.Language            = $session.system_language

    /* Division Description */
    left outer join I_DivisionText as DivText on DivText.Division = Head.OrganizationDivision
                                             and DivText.Language = $session.system_language

    /* Product Group Description */
    left outer join I_ProductGroupText_2 as PGrpText on PGrpText.ProductGroup = Item.MaterialGroup
                                                  and PGrpText.Language      = $session.system_language

    /* Payment Terms Description */
    left outer join I_PaymentTermsText as PaymText on PaymText.PaymentTerms = Head.CustomerPaymentTerms
                                                  and PaymText.Language     = $session.system_language
                                                  
//         left outer join I_SalesOrderPartner     as custname  on custname.SalesOrder     = Item.SalesOrder
                      left outer join I_Customer as Cust 
  on Cust.Customer = Head.SoldToParty                                 
                                                    
                                                                                               
                                                  

{
  key Item.SalesOrder                     as SalesDocument,
  key Item.SalesOrderItem                 as Item,

      /* Header Data */
      Head.SalesOrderType                 as SalesDocumentType,
      Head.CreationDate                   as DocumentDate,
      
      /* Org Data & Text */
      Head.SalesOrganization,
      OrgText.SalesOrganizationName       as SalesOrganizationDesc,
      
      /* Dist Channel & Name */
      Head.DistributionChannel,
      DistText.DistributionChannelName    as DistributionChannelDesc,
      
      /* Division & Name */
      Head.OrganizationDivision           as Division,
      DivText.DivisionName                as DivisionDesc,
      
      /* Sales Office & Group */
      Head.SalesOffice,
      OfficeText.SalesOfficeName          as SalesOfficeDesc,
      Head.SalesGroup,
      GroupText.SalesGroupName            as SalesGroupDesc,

      Head.TransactionCurrency            as Currency,
      
      /* Partners */
      @ObjectModel.text.element: ['CustomerName']
      Head.SoldToParty                    as Customer,
      
      @Consumption.filter.hidden: true
      cust.CustomerFullName                   as CustomerName,
      /* Fixed: Use BillTo/ShipTo alias specifically for these fields */
      BillTo.Customer                     as BillToParty,
      ShipTo.Customer                     as ShipToParty,
      Head.PurchaseOrderByCustomer        as CustomerPO,

      /* Payment Terms */
      Head.CustomerPaymentTerms           as PaymentTerms,
      PaymText.PaymentTermsName           as PaymentTermsDesc,

      /* Item Data */
      Item.Product,
      Mat.ProductName                     as Description,
      
      /* Product Group Data */
      Item.MaterialGroup                  as ProductGroup,
      PGrpText.ProductGroupName           as ProductGroupDesc,
      
      Item.Plant,
      Plant.PlantName                     as PlantDescription,
    
      /* Batch Number (From Delivery Flow) */
      Flow.Batch,

      /* Quantities */
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      Item.OrderQuantity,
      Item.OrderQuantityUnit,

      /* --- TOTALS --- */
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      cast( coalesce(Flow.TotalDeliveredQty, 0) as abap.quan(13,3) ) as DeliveredQty,

      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      cast( coalesce(Flow.TotalInvoicedQty, 0) as abap.quan(13,3) )  as InvoicedQty,

      /* Latest Documents */
      Flow.LatestDeliveryDoc              as LatestDeliveryNumber,
      Flow.LastDeliveryDate               as LastDeliveryDate,
      Flow.LatestInvoiceDoc               as LatestInvoiceNumber,

      /* --- PENDING CALCULATION --- */
      /* This is kept separate per line item as requested */
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      cast( 
        case when ( Item.OrderQuantity - coalesce(Flow.TotalDeliveredQty, 0) ) > 0
             then ( Item.OrderQuantity - coalesce(Flow.TotalDeliveredQty, 0) )
             else 0 end 
      as abap.quan(13,3) )                as PendingOrderQty,

      /* Financials */
      @Semantics.amount.currencyCode: 'Currency'
      Item.NetAmount                      as NetValue,

      /* Pricing & Tax fields */
      @Semantics.amount.currencyCode: 'Currency'
      Item.NetPriceAmount                 as BaseValuePerUnit,
      
      @Semantics.amount.currencyCode: 'Currency'
      Item.TaxAmount                      as TaxAmount,

      @Semantics.amount.currencyCode: 'Currency'
      Item.NetAmount + Item.TaxAmount     as InvoiceValue
}
