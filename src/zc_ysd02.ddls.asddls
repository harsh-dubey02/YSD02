@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for YSD02'
@Metadata.allowExtensions: true
@UI: {
  headerInfo: {
    typeName: 'YSD02',
    typeNamePlural: 'YSD02',
    title: { type: #STANDARD, value: 'SalesDocument' }
  }
}
define root view entity ZC_YSD02 
provider contract transactional_query
as projection on ZI_YSD02
{


 @UI.facet: [{ id : 'SalesDocument',
        purpose: #STANDARD,
        type: #IDENTIFICATION_REFERENCE,
        label: 'YSD02',
         position: 10 }]
         
         
    @UI.lineItem:       [{ position: 10, label: 'SalesDocument' }]
      @UI.identification: [{ position: 10, label: 'SalesDocument' }]
      @UI.selectionField: [{ position: 10 }]
    key SalesDocument,
    
    
      @UI.lineItem:       [{ position: 20, label: 'Item' }]
      @UI.identification: [{ position: 20, label: 'Item' }]
      @UI.selectionField: [{ position: 20 }]
    key Item,
    
          @UI.lineItem:       [{ position: 30, label: 'SalesDocumentType' }]
      @UI.identification: [{ position: 30, label: 'SalesDocumentType' }]
      @UI.selectionField: [{ position: 30 }]
    SalesDocumentType,
    
      @UI.lineItem:       [{ position: 40, label: 'DocumentDate' }]
      @UI.identification: [{ position: 40, label: 'DocumentDate' }]
      @UI.selectionField: [{ position: 40 }]
    DocumentDate,
    
      @UI.lineItem:       [{ position: 50, label: 'SalesOrganization' }]
      @UI.identification: [{ position: 50, label: 'SalesOrganization' }]
      @UI.selectionField: [{ position: 50 }]
    SalesOrganization,
    
      @UI.lineItem:       [{ position: 60, label: 'SalesOrganizationDesc' }]
      @UI.identification: [{ position: 60, label: 'SalesOrganizationDesc' }]
      @UI.selectionField: [{ position: 60 }]
    SalesOrganizationDesc,
    
        @UI.lineItem:       [{ position: 70, label: 'DistributionChannel' }]
      @UI.identification: [{ position: 70, label: 'DistributionChannel' }]
      @UI.selectionField: [{ position: 70 }]
    DistributionChannel,
    
      
        @UI.lineItem:       [{ position: 80, label: 'DistributionChannelDesc' }]
      @UI.identification: [{ position: 80, label: 'DistributionChannelDesc' }]
      @UI.selectionField: [{ position: 80 }]
    DistributionChannelDesc,
    
      @UI.lineItem:       [{ position: 90, label: 'Division' }]
      @UI.identification: [{ position: 90, label: 'Division' }]
      @UI.selectionField: [{ position: 90 }]
    Division,
    
     @UI.lineItem:       [{ position: 100, label: 'DivisionDesc' }]
      @UI.identification: [{ position: 100, label: 'DivisionDesc' }]
      @UI.selectionField: [{ position: 100 }]
    DivisionDesc,
    
        @UI.lineItem:       [{ position: 110, label: 'SalesOffice' }]
      @UI.identification: [{ position: 110, label: 'SalesOffice' }]
      @UI.selectionField: [{ position: 110 }]
    
    SalesOffice,
    
    @UI.lineItem:       [{ position: 120, label: 'SalesOfficeDesc' }]
      @UI.identification: [{ position: 120, label: 'SalesOfficeDesc' }]
      @UI.selectionField: [{ position: 120 }]
    SalesOfficeDesc,
    
      @UI.lineItem:       [{ position: 130, label: 'SalesGroup' }]
      @UI.identification: [{ position: 130, label: 'SalesGroup' }]
      @UI.selectionField: [{ position: 130 }]
    SalesGroup,
    
      @UI.lineItem:       [{ position: 140, label: 'SalesGroupDesc' }]
      @UI.identification: [{ position: 140, label: 'SalesGroupDesc' }]
      @UI.selectionField: [{ position: 140 }]
    
    SalesGroupDesc,
    
     @UI.lineItem:       [{ position: 150, label: 'Currency' }]
      @UI.identification: [{ position: 150, label: 'Currency' }]
      @UI.selectionField: [{ position: 150 }]
    Currency,
    
    
        @UI.lineItem: [{ position: 160, label: 'Customer' }]
      @UI.identification: [{ position: 160, label: 'Customer' }]
      @UI.selectionField: [{ position: 160 }]
    Customer,
    
       
        @UI.lineItem: [{ position: 170, label: 'Customer Description' }]
      @UI.identification: [{ position: 170, label: 'Customer Description' }]

    CustomerName,

      @UI.lineItem: [{ position: 180, label: 'Bill To Party' }]
      @UI.identification: [{ position: 180, label: 'Bill To Party' }]
    BillToParty,

      @UI.lineItem: [{ position: 190, label: 'Ship To Party' }]
      @UI.identification: [{ position: 190, label: 'Ship To Party' }]
    ShipToParty,

      @UI.lineItem: [{ position: 200, label: 'Customer PO' }]
      @UI.identification: [{ position: 200, label: 'Customer PO' }]
    CustomerPO,

      @UI.lineItem: [{ position: 210, label: 'Payment Terms' }]
      @UI.identification: [{ position: 210, label: 'Payment Terms' }]
    PaymentTerms,

      @UI.lineItem: [{ position: 220, label: 'Payment Terms Desc' }]
      @UI.identification: [{ position: 220, label: 'Payment Terms Desc' }]
    PaymentTermsDesc,

      @UI.lineItem: [{ position: 230, label: 'Product' }]
      @UI.identification: [{ position: 230, label: 'Product' }]
      @UI.selectionField: [{ position: 230 }]
    Product,

      @UI.lineItem: [{ position: 240, label: 'Description' }]
      @UI.identification: [{ position: 240, label: 'Description' }]
    Description,

      @UI.lineItem: [{ position: 250, label: 'Product Group' }]
      @UI.identification: [{ position: 250, label: 'Product Group' }]
    ProductGroup,

      @UI.lineItem: [{ position: 260, label: 'Product Group Desc' }]
      @UI.identification: [{ position: 260, label: 'Product Group Desc' }]
    ProductGroupDesc,

      @UI.lineItem: [{ position: 270, label: 'Plant' }]
      @UI.identification: [{ position: 270, label: 'Plant' }]
    Plant,

      @UI.lineItem: [{ position: 280, label: 'Plant Description' }]
      @UI.identification: [{ position: 280, label: 'Plant Description' }]
    PlantDescription,

      @UI.lineItem: [{ position: 290, label: 'Batch' }]
      @UI.identification: [{ position: 290, label: 'Batch' }]
    Batch,
    
    
    @UI.lineItem: [{ position: 300, label: 'Order Quantity' }]
      @UI.identification: [{ position: 300, label: 'Order Quantity' }]
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    OrderQuantity,
    OrderQuantityUnit,
    
     @UI.lineItem: [{ position: 310, label: 'Delivered Qty' }]
      @UI.identification: [{ position: 310, label: 'Delivered Qty' }]
    
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    DeliveredQty,
    
     @UI.lineItem: [{ position: 320, label: 'Invoiced Qty' }]
      @UI.identification: [{ position: 320, label: 'Invoiced Qty' }]
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    InvoicedQty,
    
    
      @UI.lineItem: [{ position: 330, label: 'Latest Delivery Number' }]
      @UI.identification: [{ position: 330, label: 'Latest Delivery Number' }]
    LatestDeliveryNumber,
    
     @UI.lineItem: [{ position: 340, label: 'Last Delivery Date' }]
      @UI.identification: [{ position: 340, label: 'Last Delivery Date' }]
    LastDeliveryDate,
    
     @UI.lineItem: [{ position: 350, label: 'Latest Invoice Number' }]
      @UI.identification: [{ position: 350, label: 'Latest Invoice Number' }]
    LatestInvoiceNumber,
    
    
     @UI.lineItem: [{ position: 360, label: 'Pending Order Qty' }]
      @UI.identification: [{ position: 360, label: 'Pending Order Qty' }]
      @UI.selectionField: [{ position: 360 }]
   @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    PendingOrderQty,
    
    
    @UI.lineItem: [{ position: 370, label: 'Net Value' }]
      @UI.identification: [{ position: 370, label: 'Net Value' }]
       @Semantics.amount.currencyCode: 'Currency'
    NetValue,
    
    
      @UI.lineItem: [{ position: 380, label: 'Base Value Per Unit' }]
      @UI.identification: [{ position: 380, label: 'Base Value Per Unit' }]
        @Semantics.amount.currencyCode: 'Currency'
    BaseValuePerUnit,
    
    
     @UI.lineItem: [{ position: 390, label: 'Tax Amount' }]
      @UI.identification: [{ position: 390, label: 'Tax Amount' }]
       @Semantics.amount.currencyCode: 'Currency'
    TaxAmount,
    
     @UI.lineItem: [{ position: 400, label: 'Invoice Value' }]
      @UI.identification: [{ position: 400, label: 'Invoice Value' }]
       @Semantics.amount.currencyCode: 'Currency'
    InvoiceValue
}
