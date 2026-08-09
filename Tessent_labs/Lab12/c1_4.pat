ASCII_PATTERN_FILE_VERSION = 2;


SETUP = 

    declare input bus "PI" = "/A", "/B", "/C";

    declare output bus "PO" = "/X","/Y","/Z";

end;


SCAN_TEST =

    pattern = 0;
    force   "PI" "111" 0;
    measure "PO" "111" 1;

    pattern = 1;
    force   "PI" "110" 0;
    measure "PO" "010" 1;

    pattern = 2;
    force   "PI" "100" 0;
    measure "PO" "100" 1;

    pattern = 3;
    force   "PI" "001" 0;
    measure "PO" "101" 1;

end;

