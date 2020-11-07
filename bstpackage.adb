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
                put_line("Found the node to delete");
                nodeToDelete := n;
                valueFound := True;
                put_line("checking if the node pointers are null or not.");
                if n.Left /= NULL then
                    put_line("Found the node to delete / left pointer wasn't null");
                    wentLeft := True;
                    previousNode := n;
                    lastMove := 'L';
                    removeHelper(Item, n.Left);
                elsif n.Right /= NULL then
                    put_line("Found the node to delete / right pointer wasn't null");
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
                put_line("wentLeft was true");
                if n.Right /= NULL then
                    put_line("right node wasn't null, going right.");
                    previousNode := n;
                    lastMove := 'R';
                    removeHelper(Item, n.Right);
                else
                    put_line("right node pointer was null so replacing data and whatnot.");
                    replacmentData := n.Data;
                    nodeToDelete.Data := replacmentData;
                    previousNode.Right := NULL;
                    replacementDone := True;
                end if;
            elsif wentRight and not replacementDone then
                if n.Left /= NULL then
                    put_line("left node wasn't null, going left.");
                    previousNode := n;
                    lastMove := 'L';
                    removeHelper(Item, n.Left);
                else
                    put_line("Left node pointer was null so replacing data and whatnot.");
                    replacmentData := n.Data;
                    nodeToDelete.Data := replacmentData;
                    previousNode.Left := NULL;
                    replacementDone := True;
                end if;
            elsif not replacementDone then
                put_line("Searching for data that needs to be deleted.");
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
                if compare(Item, n.Data) < 0 then
                    put_line("Went left.");
                    found := containsHelper(Item, n.Left);
                end if;
                if compare(Item, n.Data) > 0 then
                    put_line("Went right.");
                    found := containsHelper(Item, n.Right);
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
