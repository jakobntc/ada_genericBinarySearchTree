package body is

    function isEmpty(Tree : BST) return Boolean is
        if Tree.right = NULL then
            if Tree.Left = NULL then
                return True;
            else
                return False;
            end if;
        else
            return False;
        end if;
    end isEmpty;



    -- check to see if the tree is empty.
    -- if it is empty then the value would be made the root node of the BST.
    -- if it is not empty then the value would be placed in the correct location.
    procedure add(Item : ItemType; Tree : in out BST) is
        function addHelper(Item : ItemType; n : NodePtr) return Node is
        begin
            if Item < n.Data then
                if n.Left = NULL then
                    return n;
                else
                    addHelper(Item, n.Left);
                end if;
            elsif Item > n.Data then
                if n.Right = NULL then
                    return n;
                else
                    addHelper(Item, n.Right);
                end if;
            end if;
        end;
        newNode : Node := new Node;
    begin
        newNode.Data := Item;
        newNode.Left := NULL;
        newNode.Right := NULL;

        if Item < Tree.Data then
            parentNode : Node := addHelper(Item : ItemType; Tree.Left);
            parentNode.Left := newNode;
        elsif Item > Tree.Data then
            parentNode : Node := addHelper(Item : ItemType; Tree.Right);
            parentNode.Right := newNode;
        else
            put_line("Item is already in the binary search tree.");
        end if;
    end add;
