with Ada.Text_IO; use Ada.Text_IO;

package body bstpackage is

    function isEmpty(Tree : BST) return Boolean is
    begin
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
                    return n.all;
                else
                    return addHelper(Item, n.Left);
                end if;
            elsif Item > n.Data then
                if n.Right = NULL then
                    return n.all;
                else
                    return addHelper(Item, n.Right);
                end if;
            end if;
        end;
        newNode : NodePtr := new Node;
        parentNode : Node;
    begin
        newNode.Data := Item;
        newNode.Left := NULL;
        newNode.Right := NULL;

        if isEmpty(Tree) then
            if Item < Tree.Data then
                Tree.Left := newNode;
            elsif Item > Tree.Data then
                Tree.Right := newNode;
            else
                put_line("Item is already in the binary search tree.");
            end if;
        else
            if Item < Tree.Data then
                parentNode := addHelper(Item, Tree.Left);
                parentNode.Left := newNode;
            elsif Item > Tree.Data then
                parentNode := addHelper(Item, Tree.Right);
                parentNode.Right := newNode;
            else
                put_line("Item is already in the binary search tree.");
            end if;
        end if;
    end add;

    procedure remove(Item : ItemType; Tree : in out BST) is
    begin
        NULL;
    end remove;

    function contains(Item : ItemType; Tree : BST) return Boolean is
    begin
        return True;
    end contains;


    procedure printInSortedOrder(Tree : BST) is
    begin
        NULL;
    end printInSortedOrder;

end bstpackage;
