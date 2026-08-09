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

    pattern = 4;
    force   "PI" "010" 0;
    measure "PO" "101" 1;

    pattern = 5;
    force   "PI" "101" 0;
    measure "PO" "010" 1;

    pattern = 6;
    force   "PI" "011" 0;
    measure "PO" "011" 1;

    pattern = 7;
    force   "PI" "111" 0;
    measure "PO" "111" 1;

end;

