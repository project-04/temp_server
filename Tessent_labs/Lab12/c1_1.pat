ASCII_PATTERN_FILE_VERSION = 2;


SETUP = 

    declare input bus "PI" = "/A", "/B", "/C";

    declare output bus "PO" = "/X","/Y","/Z";

end;

SCAN_TEST =

    pattern = 0;
    force   "PI" "111" 0;
    measure "PO" "111" 1;

end;
