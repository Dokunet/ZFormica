*&---------------------------------------------------------------------*
*& Report Z_PM_IMPORT_CSV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT z_lude6_import_csv.

INCLUDE Z_LUDE6_CSV_IMPORT_TOP.

INCLUDE Z_LUDE6_CSV_IMPORT_SEL.

INCLUDE Z_LUDE6_CSV_IMPORT_APP.



START-OF-SELECTION.

  DATA csv_importer TYPE REF TO z_csv_import.

  csv_importer = NEW z_csv_import( ).

  csv_importer->Load_CSV_File( ).

  csv_importer->Transform_CSV_Data( ).

  TRY.
      csv_importer->Get_CSV_Data_log( ).
    CATCH cx_root INTO DATA(lv_data_conv_error).
      MESSAGE 'Es ist ein Fehler auf der Zeile: ' && gv_row && ' aufgetretten' TYPE 'E' DISPLAY LIKE 'E'.
      LEAVE PROGRAM.
  ENDTRY.
  csv_importer->commit_changes( ).
