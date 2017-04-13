:: runs the CRHM model using the .obs files

"C:\Program Files (x86)\CRHM\CRHM.exe" m:\OPS\OIB\RFS\RiverEng\Ice\CRHM\LSRM-DMS\CRHMFiles\SmokyRiverModel_Forecasts.prj


:: Run bash script to process CRHM files to single output
call m:\OPS\OIB\RFS\RiverEng\ICE\CRHM\LSRM-DMS\Scripts\SmokyDailyCRHM_with_forecasts_PostProcessing.cmd

:: get date and time

 SET _file=%~n1%
    SET _pathname=%~f1%
    SET _ext=%~x1%
    ::Get the date
   ::  note ISO 8601 date format would require 4 digit YYYY Year)
   FOR /f "tokens=6-8 delims=/ " %%G IN ('NET TIME \\%computername%') DO (
         SET _mm=%%G
         SET _dd=%%H
         SET _yy=%%I
     )
   :: Get the time
   FOR /f "tokens=1,2 delims=: " %%G IN ('time/t') DO (
         SET _hr=%%G
         SET _min=%%H
   )


:: copy final results to final output folder and add date and time
copy m:\OPS\OIB\RFS\RiverEng\ICE\CRHM\LSRM-DMS\TempFiles\CRHM_Smoky_Forecasts.txt "m:\OPS\OIB\RFS\RiverEng\Ice\CRHM\LSRM-DMS\FinalResults\CRHM_Smoky_Forecasts%_yy%-%_mm%@%_hr%-%_min%_.txt"


:: run bash script to create WISKI .tsf files
call m:\OPS\OIB\RFS\RiverEng\ICE\CRHM\LSRM-DMS\Scripts\SmokyDailyCRHM_with_forecasts_create_WISKI_files.cmd

:: copy Wiski .tsf files to final output folder (not needed; done in the above cmd (sh) file)
:: copy  m:\OPS\OIB\RFS\RiverEng\ICE\CRHM\LSRM-DMS\*.tsf "m:\OPS\OIB\RFS\RiverEng\Ice\CRHM\LSRM-DMS\FinalResults\"

:: make backup copies of data files
copy m:\OPS\OIB\RFS\RiverEng\Ice\CRHM\LSRM-DMS\OBSFiles\DailyCRHMObs_Forecasts.obs "m:\OPS\OIB\RFS\RiverEng\Ice\CRHM\LSRM-DMS\OBSFiles\backup\DailyCRHMObs_Forecasts%_yy%-%_mm%@%_hr%-%_min%_.obs"
copy m:\OPS\OIB\RFS\RiverEng\Ice\CRHM\LSRM-DMS\OBSFiles\HourlyCRHMObs_Forecasts.obs "m:\OPS\OIB\RFS\RiverEng\Ice\CRHM\LSRM-DMS\OBSFiles\backup\HourlyCRHMObs_Forecasts%_yy%-%_mm%@%_hr%-%_min%_.obs"


:: delete CRHM output files
:: del m:\OPS\OIB\RFS\RiverEng\Ice\CRHM\LSRM-DMS\CRHMFiles\CRHM_output_*.txt


:: delete temporary files
:: del m:\OPS\OIB\RFS\RiverEng\Ice\CRHM\LSRM-DMS\TempFiles\*.txt
:: del m:\OPS\OIB\RFS\RiverEng\Ice\CRHM\LSRM-DMS\TempFiles\*.tmp