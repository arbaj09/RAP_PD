@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface for partner'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@VDM.viewType: #COMPOSITE
define root view entity ZCAS_I_PARTNER
  as select from zdas_partner
  association [0..1] to I_Country  as _Country  on $projection.Country = _Country.Country
  association [0..1] to I_Currency as _Currency on $projection.PaymentCurrency = _Currency.Currency
{



      //  key partner                               as PartnerNumber,
      //
      //      name                                  as PartnerName,
      //
      //
      //      street                                as Street,
      //
      //
      //
      //      city                                  as City,
      //
      //
      //      country                               as Country,
      //
      //
      //
      //      payment_currency                      as PaymentCurrency,
      //      upper(name)                           as upper_text_PartnerName,
      //      lower(city)                           as lower_text_City,
      //
      //      concat_with_space(city , country , 2) as PartnerInfo,
      //
      //      coalesce(street,city)                 as street_null,
     


  key partner         as PartnerNumber,
    payment_currency                      as PaymentCurrency,

      name            as PartnerName,

      street          as Street,

      city            as City,

      country         as Country,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,




      _Country,
      _Currency
}
