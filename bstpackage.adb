with Ada.Text_IO; use Ada.Text_IO;

package body bstpackage is

    -- Initializing the tree the be NULL.
    procedure init(Tree : in out BST) is
    begin
        Tree := NULL;
    end init;

    -- Checking if the tree is empty.
    -- Returns true if empty.
    function isEmpty(Tree : BST) return Boolean is
    begin
        if Tree = NULL then
            return True;
        else
            return False;
        end if;
    end isEmpty;

    -- Recursivly searches the binary search tree for the correct position to
    -- add the data being passed in.
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
                raise Duplicate_Value;
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

    -- Recursibly searches the binary search tree for the data that is to
    -- be removed from the tree.
    procedure remove(Item : ItemType; Tree : in out BST) is
        nodeToDelete : NodePtr;
        previousNode : NodePtr;
        wentRight : Boolean := False;
        wentLeft : Boolean := False;
        lastMove : Character;
        replacementDone : Boolean := False;

        -- Helper procedure to handle the recursion.
        procedure removeHelper(Item : ItemType; n : NodePtr) is
        begin

            -- Handling if the item being removed is found at a current node.
            if Item = n.Data then
                nodeToDelete := n;
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

            -- finding the largest node contained in the left sub tree of the node 
            -- that is being removed. The remove is then preformed here.
            if wentLeft and not replacementDone then
                if n.Right /= NULL then
                    previousNode := n;
                    lastMove := 'R';
                    removeHelper(Item, n.Right);
                elsif n.Right = NULL then
                    nodeToDelete.Data := n.Data;
                    if n.left /= NULL then
                        previousNode.left := n.Left;
                    else
                        if lastMove = 'R' then
                            previousNode.Right := NULL;
                        elsif lastMove = 'L' then
                            previousNode.Left := NULL;
                        end if;
                    end if;
                    replacementDone := True;
                end if;

            -- finding the smallest node contained in the right sub tree of the node 
            -- that is being removed. The remove is then preformed here.
            elsif wentRight and not replacementDone then
                if n.Left /= NULL then
                    previousNode := n;
                    lastMove := 'L';
                    removeHelper(Item, n.Left);
                else
                    nodeToDelete.Data := n.Data;
                    if n.Right /= NULL then
                        previousNode.Right := n.Right;
                    else
                        if lastMove = 'R' then
                            previousNode.Right := NULL;
                        elsif lastMove = 'L' then
                            previousNode.Left := NULL;
                        end if;
                    end if;
                    replacementDone := True;
                end if;

            -- If the item that is to be removed has not been found yet, this
            -- block of code is searching for it.
            elsif not replacementDone then
                if compare(Item, n.Data) < 0 then
                    previousNode := n;
                    lastMove := 'L';
                    if n.Left /= NULL then
                        removeHelper(Item, n.Left);
                    else
                        raise No_Such_Element;
                    end if;
                elsif compare(Item, n.Data) > 0 then
                    previousNode := n;
                    lastMove := 'R';
                    if n.Right /= NULL then
                        removeHelper(Item, n.Right);
                    else
                        raise No_Such_Element;
                    end if;
                end if;
            end if;
        end; -- End of the helper procedure.
    begin
        if isEmpty(Tree) then
            put_line("Tree is empty");
        else
            removeHelper(Item, NodePtr(Tree)); -- The initial recusive call.
        end if;
    end remove;

    -- Recursivly searches the tree for the data being passed in.
    -- If the data is found in the tree then the function returns true.
    -- Otherwise false is returned.
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
            put_line("BST is empty.");
            return False;
        else
            return containsHelper(Item, NodePtr(Tree));
        end if;
    end contains;


    -- Recursibly splits the binary search tree into three parts 
    -- (left sub tree, root, right sub tree). Once there is a node that has
    -- neither a right or left node pointer, the node data is output.
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
            put_line("Tree is empty.");
        elsif Tree.Left = NULL and Tree.Right = NULL then
            printItem(Tree.Data);
        else
            printInSortedOrderHelper(NodePtr(Tree));
        end if;
    end printInSortedOrder;
end bstpackage;
