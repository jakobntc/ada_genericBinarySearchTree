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

    --
    procedure remove(Item : ItemType; Tree : in out BST) is
        nodeToDelete : NodePtr;
        previousNode : NodePtr;
        replacmentData : ItemType;
        valueFound : Boolean := False;
        wentRight : Boolean := False;
        wentLeft : Boolean := False;
        lastMove : Character;
        replacementDone : Boolean := False;
        procedure removeHelper(Item : ItemType; n : NodePtr) is
        begin
            if Item = n.Data then
                nodeToDelete := n;
                valueFound := True;
                if n.Left /= NULL then
                    wentLeft := True;
                    previousNode := n;
                    lastMove := 'L';
                    removeHelper(Item, n.Left);
                elsif n.Right /= NULL then
                    wentRight := True;
                    previousNode := n;
                    lastMove := 'R';
                    removeHelper(Item, n.Right);
                elsif n.left = null and n.Right = null then
                    if lastMove = 'L' then
                        previousNode.Left := NULL;
                    elsif lastMove = 'R' then
                        previousNode.Right := NULL;
                    end if;
                end if;
            end if;
            if wentLeft and not replacementDone then
                if n.Right /= NULL then
                    previousNode := n;
                    lastMove := 'R';
                    removeHelper(Item, n.Right);
                else
                    replacmentData := n.Data;
                    nodeToDelete.Data := replacmentData;
                    if n.left /= NULL then
                        previousNode.Right := n.Left;
                    else
                        previousNode.Left := NULL;
                    end if;
                    replacementDone := True;
                end if;
            elsif wentRight and not replacementDone then
                if n.Left /= NULL then
                    previousNode := n;
                    lastMove := 'L';
                    removeHelper(Item, n.Left);
                else
                    replacmentData := n.Data;
                    nodeToDelete.Data := replacmentData;
                    if n.Right /= NULL then
                        previousNode.Right := n.Right;
                    else
                        previousNode.Right := NULL;
                    end if;
                    replacementDone := True;
                end if;
            elsif not replacementDone then
                if compare(Item, n.Data) < 0 then
                    previousNode := n;
                    lastMove := 'L';
                    removeHelper(Item, n.Left);
                elsif compare(Item, n.Data) > 0 then
                    previousNode := n;
                    lastMove := 'R';
                    removeHelper(Item, n.Right);
                end if;
            end if;
        end;
    begin
        if isEmpty(Tree) then
            put_line("Tree is empty");
        else
            removeHelper(Item, NodePtr(Tree));
        end if;
    end remove;

    function contains(Item : ItemType; Tree : BST) return Boolean is
        function containsHelper(Item : ItemType; n : NodePtr) return Boolean is
            found : Boolean := False;
        begin
            if n.Data = Item then
                found := True;
            else
                if compare(Item, n.Data) < 0 and n.Left /= NULL then
                    found := containsHelper(Item, n.Left);
                elsif n.Left = NULL then
                    return found;
                end if;
                if compare(Item, n.Data) > 0 and n.Right /= NULL then
                    found := containsHelper(Item, n.Right);
                elsif n.Right = NULL then
                    return found;
                end if;
            end if;
            return found;
        end;
    begin
        if isEmpty(Tree) then
            put_line("BST is empty idiot.");
            return False;
        else
            return containsHelper(Item, NodePtr(Tree));
        end if;
    end contains;


    -- Split the BST into three parts (left sub tree, root, right sub tree)
    -- go down the left sub tree and split that into three parts
    -- once there is a tree with both left / right pointers that are null print the value
    procedure printInSortedOrder(Tree : BST) is
        procedure printInSortedOrderHelper(n : NodePtr) is
        begin
            if n.right = NULL and n.Left = NULL then
                printItem(n.Data);
            elsif n.Right = NULL and n.Left /= NULL then
                printInSortedOrderHelper(n.Left);
                printItem(n.Data);
            elsif n.Right /= NULL and n.Left = NULL then
                printItem(n.Data);
                printInSortedOrderHelper(n.Right);
            else
                printInSortedOrderHelper(n.Left);
                printItem(n.Data);
                printInSortedOrderHelper(n.Right);
            end if;
        end;
    begin
        if isEmpty(Tree) then
            put_line("Tree is empty idiot");
        elsif Tree.Left = NULL and Tree.Right = NULL then
            printItem(Tree.Data);
        else
            printInSortedOrderHelper(NodePtr(Tree));
        end if;
    end printInSortedOrder;

end bstpackage;
