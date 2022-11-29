<p align="center">
  <img src="./images/logo-classicblue-800px.png" alt="Intel Logo" width="250"/>
</p>

# Intel® Cloud Optimization Modules for Terraform  

© Copyright 2022, Intel Corporation

## HashiCorp Sentinel Policies

This file documents the HashiCorp Sentinel policies that apply to this module

## Policy 1

Description: The configured "sku_name" should be an Intel Xeon 3rd Generation(code-named Ice Lake) Scalable processors

Resource type: azurerm_mysql_flexible_server

Parameter: sku_name

Allowed Types

- **Memory Optimized:** MO_Standard_E2ds_v5, MO_Standard_E4ds_v5, MO_Standard_E8ds_v5, MO_Standard_E16ds_v5, MO_Standard_E20ds_v5, MO_Standard_E32ds_v5,MO_Standard_E48ds_v5, MO_Standard_E64ds_v5

## Links

<https://learn.microsoft.com/en-us/azure/virtual-machines/edv5-edsv5-series>

<https://azure.microsoft.com/en-us/pricing/details/mysql/flexible-server/>
