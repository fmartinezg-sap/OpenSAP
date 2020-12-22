@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking BO view'
define view entity ZFM_V_BOOK
  as select from zfm_t_book as Booking

  association        to parent ZFM_V_TRAVEL as _Travel     on  $projection.TravelUUID   = _Travel.TravelUUID

  association [1..1] to /DMO/I_Customer     as _Customer   on  $projection.CustomerID   = _Customer.CustomerID
  association [1..1] to /DMO/I_Carrier      as _Carrier    on  $projection.CarrierID    = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection   as _Connection on  $projection.CarrierID    = _Connection.AirlineID
                                                           and $projection.ConnectionID = _Connection.ConnectionID
  association [1..1] to /DMO/I_Flight       as _Flight     on  $projection.CarrierID    = _Flight.AirlineID
                                                           and $projection.ConnectionID = _Flight.ConnectionID
                                                           and $projection.FlightDate   = _Flight.FlightDate
  association [0..1] to I_Currency          as _Currency   on  $projection.CurrencyCode = _Currency.Currency

{

  key booking_uuid          as BookingUUID,
      travel_uuid           as TravelUUID,
      booking_id            as BookingID,
      booking_date          as BookingDate,
      customer_id           as CustomerID,
      carrier_id            as CarrierID,
      connection_id         as ConnectionID,
      flight_date           as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price          as FlightPrice,
      currency_code         as CurrencyCode,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,

      /*
        created_by            : syuname;
        created_at            : timestampl;
        last_changed_by       : syuname;
        last_changed_at       : timestampl;
        local_last_changed_at : timestampl;
        local_last_changed_by : syuname;
      */

      /* associations */
      _Travel,
      _Customer,
      _Carrier,
      _Connection,
      _Flight,
      _Currency

}
