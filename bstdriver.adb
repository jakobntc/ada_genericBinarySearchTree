with bstpackage; 
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure bstdriver is

    function compare(Item1, Item2 : Integer) return Integer is
    begin
        if Item1 > Item2 then
            return 1;
        elsif Item1 < Item2 then
            return -1;
        else
            return 0;
        end if;
    end compare;

    procedure printItem(Item : Integer) is
    begin
        put(Item, 2);
        put(' ');
    end printItem;

    package integerBST is new bstpackage(ItemType => Integer, 
                                         printItem => printItem,
                                         compare => compare
                                        );
    use integerBST;
    Tree : BST;
    command : Character;
    number : Integer := 0;
    containsReturn : Boolean := False;
begin
    init(Tree);
    while not End_of_File loop
        begin
            get(command);
            if command = 'a' or command = 'A'then 
                get(number);
                integerBST.add(number, Tree);
            elsif command = 'c' or command = 'C'then
                get(number);
                containsReturn := contains(number, Tree);
                if containsReturn then
                    put_line("YES");
                elsif not containsReturn then
                    put_line("NO");
                end if;
            elsif command = 'r' or command = 'R' then
                get(number);
                integerBST.remove(number, Tree);
            elsif command = 'p' or command = 'P' then
                printInSortedOrder(Tree);
                new_line;
            end if;
            skip_line;
        exception
            when Duplicate_Value => put_line("A duplicate value was input.");
            when No_Such_Element => Put_Line("There was no such element in this BST.");
        end;
    end loop;
end bstdriver;

