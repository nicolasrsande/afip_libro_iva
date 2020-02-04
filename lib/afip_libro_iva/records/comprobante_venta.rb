module AfipLibroIva
  require "afip_libro_iva/fixy/formatter/numeric"
  require "afip_libro_iva/fixy/formatter/numeric_currency"
  require "afip_libro_iva/fixy/formatter/numeric_cot"

  class ComprobanteVenta < Fixy::Record
    include Fixy::Formatter::Alphanumeric
    include Fixy::Formatter::Numeric
    include Fixy::Formatter::NumericCurrency
    include Fixy::Formatter::NumericCot

    set_record_length 266

    # Fields Declaration:
    # -----------------------------------------------------------
    #       name          size      Range             Format
    # ------------------------------------------------------------
    field :fecha,     8,     '1-8' ,      :numeric
    field :tipo_comprobante ,     3,     '9-11',      :numeric
    field :punto_venta ,     5,     '12-16',      :numeric
    field :numero_comprobante ,     20,     '17-36',      :numeric
    field :numero_comprobante_hasta ,     20,     '37-56',      :numeric
    field :cod_documento_comprador ,     2,     '57-58',      :numeric
    field :numero_identificador_comprador ,     20,     '59-78',      :numeric
    field :identificacion_comprador ,     30,     '79-108',      :alphanumeric
    field :importe_total ,     15,     '109-123',      :numeric_currency
    field :importe_no_gravado ,     15,     '124-138',      :numeric_currency
    field :percepcion_no_categorizados ,     15,     '139-153',      :numeric_currency
    field :importe_exento ,     15,     '154-168',      :numeric_currency
    field :importe_nacionales ,     15,     '169-183',      :numeric_currency
    field :importe_iibb ,     15,     '184-198',      :numeric_currency
    field :importe_municipales ,     15,     '199-213',      :numeric_currency
    field :importe_internos ,     15,     '214-228',      :numeric_currency
    field :codigo_moneda ,     3,     '229-231',      :alphanumeric
    field :tipo_cambio ,     10,     '232-241',      :numeric_cot
    field :cantidad_alicuotas ,     1,     '242-242',      :numeric
    field :codigo_operacion ,     1,     '243-243',      :alphanumeric
    field :importe_otros_tributos ,     15,     '244-258',      :numeric_currency
    field :vencimiento_pago ,     8,     '259-266',      :numeric

    def initialize(comprobante)
      @fecha = comprobante[:fecha].strftime('%Y%m%d')
      @tipo_comprobante = comprobante[:tipo_comprobante]
      @punto_venta = comprobante[:punto_venta]
      @numero_comprobante = comprobante[:numero_comprobante]
      @numero_comprobante_hasta = comprobante[:numero_comprobante]
      @cod_documento_comprador = comprobante[:cod_documento_comprador] || 80
      @numero_identificador_comprador = comprobante[:numero_identificador_comprador]
      @identificacion_comprador = comprobante[:identificacion_comprador].truncate(29) || 'SIN IDENTIFICAR'
      @importe_total = total(comprobante)
      @importe_no_gravado = comprobante[:importe_no_gravado] || 0
      @percepcion_no_categorizados = 0
      @importe_exento = comprobante[:importe_exento] || 0
      @importe_nacionales = comprobante[:importe_nacionales] || 0
      @importe_iibb = comprobante[:importe_iibb] || 0
      @importe_municipales = comprobante[:importe_municipales] || 0
      @importe_internos = comprobante[:importe_internos] || 0
      @codigo_moneda = comprobante[:codigo_moneda] || 'PES'
      @tipo_cambio = comprobante[:tipo_cambio] || 1
      @cantidad_alicuotas = comprobante[:alicuotas].count
      @codigo_operacion = comprobante[:codigo_operacion] || 0
      @importe_otros_tributos = comprobante[:otros_tributos] || 0
      @vencimiento_pago = comprobante[:vencimiento_pago] || comprobante[:fecha].strftime('%Y%m%d')
    end

    attr_reader :fecha, :tipo_comprobante, :punto_venta, :numero_comprobante, :numero_comprobante_hasta, :cod_documento_comprador, :identificacion_comprador,
    :numero_identificador_comprador, :importe_total, :importe_no_gravado, :percepcion_no_categorizados, :importe_exento, :importe_nacionales,
    :importe_iibb, :importe_municipales, :importe_internos, :codigo_moneda, :tipo_cambio, :cantidad_alicuotas, :codigo_operacion, :importe_otros_tributos,
    :vencimiento_pago

    def total(comprobante) # Calcularemos el total en base a las alicuotas y impuestos para que el valor sea exacto.
      importe_total = 0
      importe_total += comprobante.values_at(:importe_internos, :importe_exento, :importe_iibb, :importe_municipales,
                                             :importe_no_gravado, :importe_nacionales).compact.reduce(0, :+)
      comprobante[:alicuotas].each do |alicuota|
        importe_total += alicuota.values_at(:importe_neto_gravado, :impuesto_liquidado).compact.reduce(0, :+)
      end
      importe_total
    end
  end
end