with Ada.Text_IO; use Ada.Text_IO;

package body bstpackage is

    procedure init(Tree : in out BST) is
    begin
        Tree := NULL;
    end init;

    function isEmpty(Tree : BST) return Boolean is
    begin
        if Tree = NULL then
            return True;
        else
            return False;
        end if;
    end isEmpty;

    -- check to see if the tree is empty.
    -- if it is empty then the value would be made the root node of the BST.
    -- if it is not empty then the value would be placed in the correct location.
    procedure add(Item : ItemType; Tree : in out BST) is
        newNode : NodePtr := new Node;
        procedure addHelper(Item : ItemType; n : NodePtr) is
        begin

            if compare(Item, n.Data) < 0 then
                if n.Left = NULL then
                    n.Left := newNode;
                else
                    addHelper(Item, n.Left);
                end if;
            elsif compare(Item, n.Data) > 0 then
                if n.Right = NULL then
                    n.Right := newNode;
                else
                    addHelper(Item, n.Right);
                end if;
            else
                put("Item is already in the array");
            end if;
        end;
    begin
        newNode.Data := Item;
        newNode.Left := NULL;
        newNode.Right := NULL;

        if isEmpty(Tree) then
            Tree := BST(newNode);
        else
            addHelper(Item, NodePtr(Tree));
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


    -- Split the BST into three parts (left sub tree, root, right sub tree)
    -- go down the left sub tree and split that into three parts
    -- once there is a tree with both left / right pointers that are null print the value
    procedure printInSortedOrder(Tree : BST) is
        procedure printInSortedOrderHelper(n : NodePtr) is
        begin
            null;
        end;
    begin
        
        if isEmpty(Tree) then
            null;

        end if;
    end printInSortedOrder;

end bstpackage;
