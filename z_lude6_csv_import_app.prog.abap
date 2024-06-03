*&---------------------------------------------------------------------*
*& Include          Z_PM_IMPORT_APP
*&---------------------------------------------------------------------*
"-Begin-----------------------------------------------------------------

CLASS z_csv_import DEFINITION INHERITING FROM cx_static_check.

  PUBLIC SECTION.

    METHODS load_csv_file.

    METHODS transform_csv_data.

    METHODS get_csv_data_ants EXCEPTIONS  cx_sy_conversion_error.
    METHODS get_csv_data_users EXCEPTIONS  cx_sy_conversion_error.
    METHODS get_csv_data_log EXCEPTIONS  cx_sy_conversion_error.

    METHODS validate_matnr.

    METHODS commit_changes.

    METHODS check_conversion
      IMPORTING
        value TYPE any.

    METHODS: validation IMPORTING exc_val TYPE abap_typekind
                                  db_val  TYPE abap_typekind
                                  row     TYPE int8
                                  col     TYPE int8.

  PROTECTED SECTION.

    DATA g_csv_data TYPE stringtab .
    DATA g_error_flag TYPE abap_bool VALUE abap_false.
    DATA g_tab_fields TYPE STANDARD TABLE OF String .
    DATA g_tab_vals TYPE STANDARD TABLE OF String .


  PRIVATE SECTION.

ENDCLASS.



CLASS z_csv_import IMPLEMENTATION.

  METHOD validate_matnr.

    SELECT SINGLE * FROM zmm_mara INTO @DATA(placeholder) WHERE matnr = @p_matnr.

    IF sy-subrc NE 0.
      MESSAGE 'Materialnummer wurde nicht gefunden' TYPE 'I' DISPLAY LIKE 'E'.
      LEAVE TO TRANSACTION 'Z_PM_MAT_IMPORT_CSV'.
    ENDIF.


  ENDMETHOD.

  METHOD validation.
*    DATA: lv_typdescr         TYPE REF TO cl_abap_typedescr.
*    DATA: lv_typdescr_db         TYPE REF TO cl_abap_typedescr.
*    lv_typdescr = cl_abap_typedescr=>describe_by_data( <fs_vals> ).
*    lv_typdescr_db = cl_abap_typedescr=>describe_by_data( ll_mm_co-umrez ).

    IF  exc_val NE db_val.
      MESSAGE 'Typen stimmen nicht überein. Zeile: ' && row && ' Spalte:  ' && col TYPE 'I' DISPLAY LIKE 'E'.
      LEAVE TO SCREEN 0.
    ENDIF.
  ENDMETHOD.

  "-Main----------------------------------------------------------------
  METHOD get_csv_data_ants.
    "-Main----------------------------------------------------------------
    IF g_csv_data IS NOT INITIAL AND g_error_flag = abap_false.

      DATA: "l_zformica_ants TYPE TABLE OF zformica_ants,
            l_zformica_ants_line LIKE LINE OF l_zformica_ants.

      LOOP AT g_csv_data ASSIGNING FIELD-SYMBOL(<fs_csv_data>).
        SPLIT <fs_csv_data> AT ';' INTO TABLE g_tab_vals.
        DATA: l_string TYPE string.
        l_zformica_ants_line-mandt = g_tab_vals[ 1 ].
        l_zformica_ants_line-ahid = g_tab_vals[ 2 ].
        l_zformica_ants_line-ahpkuid = g_tab_vals[ 3 ].
        l_zformica_ants_line-aherfasser = g_tab_vals[ 4 ].
        l_string = g_tab_vals[ 5 ].
        REPLACE ALL OCCURRENCES OF '.' IN l_string WITH ''.
        l_zformica_ants_line-aherfdatum = l_string.

        l_zformica_ants_line-ahnestcode = g_tab_vals[ 6 ].
        l_zformica_ants_line-ahart = g_tab_vals[ 7 ].
        l_zformica_ants_line-ahbestimmt = g_tab_vals[ 8 ].
        l_zformica_ants_line-ahnestgroesse = g_tab_vals[ 9 ].
        l_zformica_ants_line-ahaktivitaet = g_tab_vals[ 10 ].
        l_zformica_ants_line-ahnestlage = g_tab_vals[ 11 ].
        l_zformica_ants_line-ahtot = g_tab_vals[ 12 ].
        l_zformica_ants_line-ahbesuch = g_tab_vals[ 13 ].

        l_string = g_tab_vals[ 14 ].
        REPLACE ALL OCCURRENCES OF '.' IN l_string WITH ''.
        l_zformica_ants_line-ahbesuchdatum =  l_string.

        l_zformica_ants_line-ahbemerkung = g_tab_vals[ 15 ].
        l_zformica_ants_line-ahgemeinde = g_tab_vals[ 16 ].
        l_zformica_ants_line-ahflurname = g_tab_vals[ 17 ].

        l_string = g_tab_vals[ 18 ].
        REPLACE ALL OCCURRENCES OF '.' IN l_string WITH ''.
        l_zformica_ants_line-aheditdat =  l_string.

        l_zformica_ants_line-ahedituser = g_tab_vals[ 19 ].
        l_zformica_ants_line-ahx = g_tab_vals[ 20 ].
        l_zformica_ants_line-ahy = g_tab_vals[ 21 ].
        l_zformica_ants_line-ahz = g_tab_vals[ 22 ].
        l_zformica_ants_line-ahtemp = g_tab_vals[ 23 ].
        l_zformica_ants_line-ahwetter = g_tab_vals[ 24 ].
        APPEND l_zformica_ants_line TO l_zformica_ants.
      ENDLOOP.

    ENDIF.

    "-End-------------------------------------------------------------------
  ENDMETHOD.

  METHOD get_csv_data_log.
    "-Main----------------------------------------------------------------
    IF g_csv_data IS NOT INITIAL AND g_error_flag = abap_false.

      DATA: "l_zformica_ants TYPE TABLE OF zformica_ants,
            l_zformica_log_line LIKE LINE OF l_zformica_log.

      LOOP AT g_csv_data ASSIGNING FIELD-SYMBOL(<fs_csv_data>).
        SPLIT <fs_csv_data> AT ';' INTO TABLE g_tab_vals.
        DATA: l_string TYPE string.
        l_zformica_log_line-mandt = g_tab_vals[ 1 ].
        l_zformica_log_line-ahrandid = g_tab_vals[ 2 ].
        l_zformica_log_line-ahid = g_tab_vals[ 3 ].
        l_zformica_log_line-ahpkuid = g_tab_vals[ 4 ].
        l_zformica_log_line-aherfasser = g_tab_vals[ 5 ].
        l_string = g_tab_vals[ 6 ].
        REPLACE ALL OCCURRENCES OF '.' IN l_string WITH ''.
        l_zformica_log_line-aherfadat = l_string.

        l_zformica_log_line-ahnestcode = g_tab_vals[ 7 ].
        l_zformica_log_line-ahart = g_tab_vals[ 8 ].
        l_zformica_log_line-aharttext = g_tab_vals[ 9 ].
        l_zformica_log_line-ahbestimmt = g_tab_vals[ 10 ].
        l_zformica_log_line-ahnestgroesse = g_tab_vals[ 11 ].
        l_zformica_log_line-ahaktivitaet = g_tab_vals[ 12 ].
        l_zformica_log_line-ahnestlage = g_tab_vals[ 13 ].
        l_zformica_log_line-ahvegetation = g_tab_vals[ 14 ].
        l_zformica_log_line-ahtot = g_tab_vals[ 15 ].
        l_zformica_log_line-ahbesuch = g_tab_vals[ 16 ].

        l_string = g_tab_vals[ 17 ].
        REPLACE ALL OCCURRENCES OF '.' IN l_string WITH ''.
        l_zformica_log_line-ahbesuchdat = l_string.

        l_zformica_log_line-ahbem = g_tab_vals[ 18 ].
        l_zformica_log_line-ahgem = g_tab_vals[ 19 ].
        l_zformica_log_line-ahflurnam = g_tab_vals[ 20 ].

        l_string = g_tab_vals[ 21 ].
        REPLACE ALL OCCURRENCES OF '.' IN l_string WITH ''.
        l_zformica_log_line-aheditdat = l_string.

        l_zformica_log_line-ahedituser = g_tab_vals[ 22 ].
        l_zformica_log_line-ahx = g_tab_vals[ 23 ].
        l_zformica_log_line-ahy = g_tab_vals[ 24 ].
        l_zformica_log_line-ahtemp = g_tab_vals[ 25 ].
        l_zformica_log_line-ahwetter = g_tab_vals[ 26 ].
        l_zformica_log_line-ahlokalid = g_tab_vals[ 27 ].


        APPEND l_zformica_log_line TO l_zformica_log.
      ENDLOOP.

    ENDIF.
  ENDMETHOD.
  METHOD get_csv_data_users.
    "-Main----------------------------------------------------------------
    IF g_csv_data IS NOT INITIAL AND g_error_flag = abap_false.

      DATA: "l_zformica_ants TYPE TABLE OF zformica_ants,
            l_zformica_parish_line LIKE LINE OF l_zformica_parish.

      LOOP AT g_csv_data ASSIGNING FIELD-SYMBOL(<fs_csv_data>).
        SPLIT <fs_csv_data> AT ';' INTO TABLE g_tab_vals.
        l_zformica_parish_line-mandt = g_tab_vals[ 1 ].
        l_zformica_parish_line-geid = g_tab_vals[ 2 ].
        l_zformica_parish_line-gebfsnr = g_tab_vals[ 3 ].
        l_zformica_parish_line-geort = g_tab_vals[ 4 ].
        l_zformica_parish_line-gekanton = g_tab_vals[ 5 ].
        l_zformica_parish_line-geanzeigen = g_tab_vals[ 6 ].
        l_zformica_parish_line-gekuerzel = g_tab_vals[ 7 ].
        l_zformica_parish_line-gex = g_tab_vals[ 8 ].
        l_zformica_parish_line-gey = g_tab_vals[ 9 ].

        APPEND l_zformica_parish_line TO l_zformica_parish.
      ENDLOOP.

    ENDIF.

    "-End-------------------------------------------------------------------
  ENDMETHOD.

  METHOD check_conversion.
    DATA: lv_value TYPE string,
          lv_num   TYPE i.
*    lv_value = CONV #( value ).
*    MOVE EXACT lv_value TO lv_num.
*    IF sy-subrc <> 0.
*      MESSAGE 'Fehler bei der Konvertierung' TYPE 'I' DISPLAY LIKE 'E'.
*      LEAVE TO SCREEN 0.
*    ENDIF.
  ENDMETHOD.

  METHOD load_csv_file.
    "-Begin-----------------------------------------------------------------

    DATA: lv_filename     TYPE string,
          lv_fullpath     TYPE string,
          lv_path         TYPE string,
          lv_number_files TYPE i.
    DATA p_fname TYPE file_table-filename.

    DATA: lv_rc TYPE i.
    DATA: it_files TYPE filetable.
    DATA: lv_action TYPE i.

* File-Tabelle leeren, da hier noch alte Einträge von vorherigen Aufrufen drin stehen können
    CLEAR it_files.

* FileOpen-Dialog aufrufen
    TRY.
        cl_gui_frontend_services=>file_open_dialog( EXPORTING
                                                      file_filter    = |csv (*.csv)\|*.csv\|{ cl_gui_frontend_services=>filetype_all }|
                                                      multiselection = abap_false
                                                    CHANGING
                                                      file_table  = it_files
                                                      rc          = lv_rc
                                                      user_action = lv_action ).

*        IF lv_action = cl_gui_frontend_services=>action_ok.
** wenn Datei ausgewählt wurde
*          IF lines( it_files ) > 0.
** ersten Tabelleneintrag lesen
*            p_fname = it_files[ 1 ]-filename.
*          ENDIF.
*        ENDIF.
*
*      CATCH cx_root INTO DATA(e_text).
*        MESSAGE e_text->get_text( ) TYPE 'I'.
    ENDTRY.

*      CHANGING
*        FILENAME                  =   lv_filename            " Dateiname für Sichern
*        path                      =   lv_path               " Pfad zu Datei
*        fullpath                  =   lv_fullpath               " Pfad + Dateiname
*
*    ).

    lv_fullpath = CONV #( it_files[ 1 ]-filename ).

    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename = lv_fullpath
        filetype = 'ASC'
      TABLES
        data_tab = g_csv_data
      EXCEPTIONS
        OTHERS   = 1.
    IF sy-subrc  <> 0.
      g_error_flag = abap_true.
    ENDIF.
    "-End-------------------------------------------------------------------
  ENDMETHOD.


  METHOD transform_csv_data.
    "-Begin-----------------------------------------------------------------

    "-Variables-----------------------------------------------------------

    DATA l_Fld1 TYPE String VALUE ''.
    DATA l_Fld2 TYPE String VALUE ''.
    DATA l_Fld3 TYPE String VALUE ''.
    DATA l_FldRest TYPE String VALUE ''.


    FIELD-SYMBOLS  <Line> TYPE String.

    "-Main----------------------------------------------------------------
    IF g_csv_data IS NOT INITIAL AND g_error_flag = abap_false.

      "-Manipulate Headline---------------------------------------------
*      READ TABLE g_csv_data INDEX 1 ASSIGNING  <Line>.
*      <Line> = 'MANDT;' &&  <Line>.
*
*      CONDENSE  <Line> NO-GAPS.
*      SPLIT  <Line> AT ';' INTO TABLE g_tab_fields.

    ENDIF.
    LOOP AT g_csv_data FROM 1 ASSIGNING  <Line>.
      <Line> = sy-mandt && ';' &&  <Line>.
    ENDLOOP.


  ENDMETHOD.

  METHOD commit_changes.
    DELETE FROM zformica_log.
*    DELETE FROM zformica_parish.
*    DELETE FROM zformica_ants.
    COMMIT WORK AND WAIT.
*    WRITE 'hello world'.
    INSERT zformica_log FROM TABLE l_zformica_log.
*    INSERT zformica_parish FROM TABLE l_zformica_parish.
*    INSERT zformica_ants FROM TABLE l_zformica_ants.
    COMMIT WORK AND WAIT.
    WRITE sy-subrc.

  ENDMETHOD.

ENDCLASS.

"-End-------------------------------------------------------------------
