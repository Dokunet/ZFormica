*&---------------------------------------------------------------------*
*& Include Z_PM_IMPORT_TOP                          - Report Z_PM_IMPORT_CSV
*&---------------------------------------------------------------------*

TYPES: BEGIN OF gty_mat_stamm,
         ean11_st  TYPE zmm_marm-ean11,
         ean11_co  TYPE zmm_marm-ean11,
         umrez_co  TYPE zmm_marm-umrez,
         umrez_pal TYPE zmm_marm-umrez,
         umrez_pll TYPE zmm_marm-umrez,
         umrez_um  TYPE zmm_marm-umrez,
         brgew_pal TYPE zmm_marm-brgew,
         brgew_st  TYPE zmm_marm-brgew,
         brgew_co  TYPE zmm_marm-brgew,
         brgew_um  TYPE zmm_marm-brgew,
         laeng_st  TYPE zmm_marm-laeng,
         breit_st  TYPE zmm_marm-breit,
         hoehe_st  TYPE zmm_marm-hoehe,
         hoehe_pal TYPE zmm_marm-hoehe,
         mhdrz     TYPE zmm_mara-mhdrz,
         meins     TYPE zmm_mara-meins,
         zzsaison  TYPE zmm_mara-zzsaison,
         maktx     TYPE zmm_makt-maktx,
       END OF gty_mat_stamm.

TYPES: BEGIN OF gty_col_names,
         col       TYPE c,
         col_name  TYPE char30,
         col_titel TYPE char30,
       END OF gty_col_names.

DATA: int_val TYPE p LENGTH 4.


DATA: gt_mat_stamm   TYPE TABLE OF gty_mat_stamm,
      gt_col_names   TYPE TABLE OF gty_col_names,
      gt_mm_mara     TYPE TABLE OF zmm_mara,
      gt_mm_marm_co  TYPE TABLE OF zmm_marm,
      gt_mm_marm_st  TYPE TABLE OF zmm_marm,
      gt_mm_marm_pal TYPE TABLE OF zmm_marm,
      gt_mm_marm_pll TYPE TABLE OF zmm_marm,
      gt_mm_marm_um  TYPE TABLE OF zmm_marm,
      gt_mm_makt     TYPE TABLE OF zmm_makt,
      gt_rawdata     TYPE xstring.
DATA converted TYPE string.

TABLES: zmm_marm, zmm_mara, zmm_makt.


*DATA ll_mat_stamm LIKE LINE OF gt_mat_stamm.
*DATA ll_mm_mara LIKE LINE OF gt_mm_mara.
*DATA ll_mm_co LIKE LINE OF gt_mm_marm_co.
*DATA ll_mm_pll LIKE LINE OF gt_mm_marm_pll.
*DATA ll_mm_pal LIKE LINE OF gt_mm_marm_pal.
*DATA ll_mm_um LIKE LINE OF gt_mm_marm_um.
*DATA ll_mm_st LIKE LINE OF gt_mm_marm_st.
*DATA ll_mm_makt LIKE LINE OF gt_mm_makt.

DATA: op_ref   TYPE REF TO cx_root,
      msg_text TYPE string.

DATA: gv_col TYPE int8,
      gv_row TYPE int8.
TABLES: zformica_ants.

DATA: l_zformica_ants TYPE TABLE OF zformica_ants.
DATA: l_zformica_parish TYPE TABLE OF zformica_parish.
DATA: l_zformica_log TYPE TABLE OF zformica_log.
