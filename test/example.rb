## Example - Comprobante Venta
# Todos los campos que no sean expresados, se tomaran con el valor default. A continuacion se
# enuncian los campos OBLIGATORIOS del comprobante.
#
# PAUTAS:
# Deben agregarse al array la cantidad de comprobantes que desee incluir en el archivo.
# Las alicuotas pueden ingresarse la cantidad que sean como tenga el comprobante.
# En los valores numericos, el sistema espera numeros de tipo FLOAT:2

comprobantes = [{ fecha: Date.new(2019-01-01),
                tipo_comprobante: 06,
                punto_venta: 1,
                numero_comprobante: 1234,
                cod_documento_comprador: 1,
                numero_identificador_comprador: 11111111111,
                  razon_social: 'PANCHITO S.A',
                cantidad_alicuotas: 2,
                alicuotas: [{alicuota_iva: 'IVA21',
                             importe_neto_gravado: 1500,
                             importe_iva: 143
                              },
                            {alicuota_iva: 'IVA10.5',
                             importe_neto_gravado: 2313,
                             importe_iva: 313
                              }]
                },
                { tipo_comprobante: 06,
                punto_venta: 1,
                numero_comprobante: 1234,
                cod_documento_comprador: 1,
                numero_identificador_comprador: 11111111111,
                  razon_social: 'PANCHITO S.A',
                cantidad_alicuotas: 2,
                alicuotas: [{alicuota_iva: 'IVA21',
                             importe_neto_gravado: 1500,
                             importe_iva: 143
                            },
                            {alicuota_iva: 'IVA10.5',
                             importe_neto_gravado: 2313,
                             importe_iva: 313
                            }]
                }]


## Totalidad de campos del comprobante:
# DEFINICION


## Example - Comprobante Compra
# Todos los campos que no sean expresados, se tomaran con el valor default. A continuacion se
# enuncian los campos OBLIGATORIOS del comprobante.
#
## Las alicuotas pueden ingresarse la cantidad que sean como tenga el comprobante.


##