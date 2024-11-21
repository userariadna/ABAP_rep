DATA: zip_tool TYPE REF TO cl_abap_zip,
filename TYPE string,
filename_zip TYPE string.


DATA: t_data_tab TYPE TABLE OF Z255,


bin_size TYPE i,
buffer_x TYPE xstring,
buffer_zip TYPE xstring.


filename = ariadna
  DESCRIBE TABLE html_tab LINES tab_lines.
  bin_size = tab_lines * 255.

  CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'

  EXPORTING 
    input_length = bin_size

  IMPORTING
    buffer = buffer_x

  TABLES 
    binary_tab = html_tab.

  IF sy-subrc <> 0.
  * message id sy-msgid 

   ENDIF.

CREATE OBJECT zip_tool.
* add binary file  
CALL METHOD zip_tool-> add
EXPORTING 
  name = 'FSSAI-MAIL.HTML'
  content = buffer_x

*get binary ZIP file
  CALL METHOD zip_tool->save
  RECEIVING 

 zip = buffer_zip.
 CLEAR: t_data_tab[], bin_size.

  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
  EXPORTING
 buffer = buffer_zip

  IMPORTING 
  output_length = bin_size

  TABLES 
   binary_tab = html_tab. 





