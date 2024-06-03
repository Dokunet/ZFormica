*&---------------------------------------------------------------------*
*& Report Z_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_test_lude6.



TABLES: zformica_ants, zformica_users.

TYPES: BEGIN OF ty_temp,
         journal_entry_id TYPE char30,
         nestid           TYPE char30,
         userid           TYPE char30,
         Field            TYPE char50,
         old_value        TYPE char250,
         new_value        TYPE char250,
       END OF ty_temp.

DATA: lt_temp4 TYPE TABLE OF ty_temp.
DATA: ll_temp LIKE LINE OF lt_temp4.

*
*SELECT a~AHID, a~ahnestcode, b~arname, a~ahnestgroesse, a~ahflurname, a~ahtot
*  FROM zformica_ants as a
*  join zformica_species as b
*  on b~arid = a~ahart
*  INTO TABLE @DATA(lt_temp).
*
*LOOP AT lt_temp ASSIGNING  FIELD-SYMBOL(<fs>).
*  DATA(lv_temp) = <fs>-ahbemerkung.
*  REPLACE ALL OCCURRENCES OF REGEX '\n' IN lv_temp WITH '/'.
*  <fs>-ahbemerkung = lv_temp.
*ENDLOOP.


*SELECT * FROM zformica_log INTO TABLE @DATA(lt_temp).
*SELECT * FROM zformica_ants INTO TABLE @DATA(lt_temp2).
*
SELECT a~ahid, a~ahy, a~ahx, a~ahflurnam, a~ahbem, a~ahnestcode,
  b~arname, a~ahnestgroesse, a~ahtot, a~aheditdat, a~aherfasser
  FROM zformica_log AS a
   JOIN zformica_species AS b
  ON b~arid = a~ahart
  INTO TABLE @DATA(lt_temp3).

DATA: counter TYPE int8.
DATA: indexcounter TYPE int8.
SORT lt_temp3 BY ahid aheditdat ASCENDING.

indexcounter = 1.

LOOP AT lt_temp3 FROM 2 ASSIGNING FIELD-SYMBOL(<fs>).
  DATA(id) = lt_temp3[ indexcounter ]-ahid.
  IF <fs>-ahid = id.
    IF <fs>-ahy NE lt_temp3[ indexcounter ]-ahy.
      counter = counter + 1.
      ll_temp-field = 'LATITUDE'.
      ll_temp-journal_entry_id = counter.
      ll_temp-userid = lt_temp3[ indexcounter ]-aherfasser.
      ll_temp-nestid = <fs>-ahid.
      ll_temp-old_value = lt_temp3[ indexcounter ]-ahy.
      ll_temp-new_value = <fs>-ahy.
      APPEND ll_temp TO lt_temp4.
    ENDIF.
    IF <fs>-ahx NE lt_temp3[ indexcounter ]-ahx.
      counter = counter + 1.
      ll_temp-field = 'LONGITUDE'.
      ll_temp-journal_entry_id = counter.
      ll_temp-userid = lt_temp3[ indexcounter ]-aherfasser.
      ll_temp-nestid = <fs>-ahid.
      ll_temp-old_value = lt_temp3[ indexcounter ]-ahx.
      ll_temp-new_value = <fs>-ahx.
      APPEND ll_temp TO lt_temp4.
    ENDIF.
    IF <fs>-ahflurnam NE lt_temp3[ indexcounter ]-ahflurnam.
      counter = counter + 1.
      ll_temp-field = 'FIELDNAME'.
      ll_temp-journal_entry_id = counter.
      ll_temp-userid = lt_temp3[ indexcounter ]-aherfasser.
      ll_temp-nestid = <fs>-ahid.
      ll_temp-old_value = lt_temp3[ indexcounter ]-ahflurnam.
      ll_temp-new_value = <fs>-ahflurnam.
      APPEND ll_temp TO lt_temp4.
    ENDIF.
    IF <fs>-ahbem NE lt_temp3[ indexcounter ]-ahbem.
      counter = counter + 1.
      ll_temp-field = 'COMMENT'.
      ll_temp-journal_entry_id = counter.
      ll_temp-userid = lt_temp3[ indexcounter ]-aherfasser.
      ll_temp-nestid = <fs>-ahid.
      ll_temp-old_value = lt_temp3[ indexcounter ]-ahbem.
      ll_temp-new_value = <fs>-ahbem.
      REPLACE ALL OCCURRENCES OF REGEX '\n' IN ll_temp-old_value WITH '/'.
      REPLACE ALL OCCURRENCES OF REGEX '\n' IN ll_temp-new_value WITH '/'.
      APPEND ll_temp TO lt_temp4.
    ENDIF.
    IF <fs>-ahnestcode NE lt_temp3[ indexcounter ]-ahnestcode.
      counter = counter + 1.
      ll_temp-field = 'NESTCODE'.
      ll_temp-journal_entry_id = counter.
      ll_temp-userid = lt_temp3[ indexcounter ]-aherfasser.
      ll_temp-nestid = <fs>-ahid.
      ll_temp-old_value = lt_temp3[ indexcounter ]-ahnestcode.
      ll_temp-new_value = <fs>-ahnestcode.
      APPEND ll_temp TO lt_temp4.
    ENDIF.
    IF <fs>-arname NE lt_temp3[ indexcounter ]-arname.
      counter = counter + 1.
      ll_temp-field = 'SPECIES'.
      ll_temp-journal_entry_id = counter.
      ll_temp-userid = lt_temp3[ indexcounter ]-aherfasser.
      ll_temp-nestid = <fs>-ahid.
      ll_temp-old_value = lt_temp3[ indexcounter ]-arname.
      ll_temp-new_value = <fs>-arname.
      APPEND ll_temp TO lt_temp4.
    ENDIF.
    IF <fs>-ahnestgroesse NE lt_temp3[ indexcounter ]-ahnestgroesse.
      counter = counter + 1.
      ll_temp-field = 'SIZE'.
      ll_temp-journal_entry_id = counter.
      ll_temp-userid = lt_temp3[ indexcounter ]-aherfasser.
      ll_temp-nestid = <fs>-ahid.
      ll_temp-old_value = lt_temp3[ indexcounter ]-ahnestgroesse.
      ll_temp-new_value = <fs>-ahnestgroesse.
      APPEND ll_temp TO lt_temp4.
    ENDIF.
    IF <fs>-ahtot NE lt_temp3[ indexcounter ]-ahtot.
      counter = counter + 1.
      ll_temp-field = 'ACTIVE'.
      ll_temp-journal_entry_id = counter.
      ll_temp-userid = lt_temp3[ indexcounter ]-aherfasser.
      ll_temp-nestid = <fs>-ahid.
      ll_temp-old_value = lt_temp3[ indexcounter ]-ahtot.
      ll_temp-new_value = <fs>-ahtot.
      APPEND ll_temp TO lt_temp4.
    ENDIF.
  ENDIF.
  indexcounter = indexcounter + 1.
ENDLOOP.




WRITE 'test'.
