ASCII_PATTERN_FILE_VERSION = 2;


SETUP = 

    declare input bus "PI" = "/a", "/b", "/c", "/d";

    declare output bus "PO" = "/z";

end;

SCAN_TEST =

    pattern = 0;
    force   "PI" "0001" 0;
    measure "PO" "1" 1;

    pattern = 1;
    force   "PI" "1001" 0;
    measure "PO" "1" 1;

    pattern = 2;
    force   "PI" "1101" 0;
    measure "PO" "1" 1;

    pattern = 3;
    force   "PI" "1111" 0;
    measure "PO" "0" 1;

end;

