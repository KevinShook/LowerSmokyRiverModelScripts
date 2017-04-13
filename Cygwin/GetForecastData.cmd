:: This command file downloads and processes
:: EC weather forecast scenarios
:: It calls .cmd files which execute bash scripts
:: using the program Cygwin

@Echo off

CALL M:\OPS\OIB\RFS\RiverEng\ICE\CRHM\LSRM-DMS\Scripts\get_AT_forecast.cmd
CALL M:\OPS\OIB\RFS\RiverEng\ICE\CRHM\LSRM-DMS\Scripts\get_PR_forecast.cmd
CALL M:\OPS\OIB\RFS\RiverEng\ICE\CRHM\LSRM-DMS\Scripts\get_RH_forecast.cmd
CALL M:\OPS\OIB\RFS\RiverEng\ICE\CRHM\LSRM-DMS\Scripts\get_U_forecast.cmd
CALL M:\OPS\OIB\RFS\RiverEng\ICE\CRHM\LSRM-DMS\Scripts\get_V_forecast.cmd

