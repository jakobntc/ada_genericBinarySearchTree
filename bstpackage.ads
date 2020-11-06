generic
    -- This is the type of Item stored in the Data
    -- field of each Binary Search Tree Node.
    type ItemType is private;

    -- This is a procedure specified when the user creates
    -- an instance of the BST package.
    -- The procedure tells the BST package how to print 
    -- a single instance of ItemType.
    with procedure printItem(Item : ItemType);

    -- This is a function defined when the user creates an
    -- instance of the BST package.
    -- It should have the following behvior:
    -- If Item1 < Item2, then return -1.
    -- If Item1 > Item2, then return 1.
    -- If Item1 = Item2, then return 0.
    -- This matches the behavior of Comparators and
    -- Comparable interfaces in Java.
    -- You use it to determine whether to make left / right turns.
    with function compare(Item1, Item2 : ItemType) return Integer;

package bstpackage is
    -- Thrown whenever user attempts to remove element
    -- that doesn't exist.
    No_Such_Element : Exception;


    -- Thrown whenever user attempts to add an element
    -- that already exists in the tree.
    Duplicate_Value : Exception;

    -- The BST type, defined in private section below.
    type BST is limited private;
    
    -- Return whether or not the tree has size 0
    function isEmpty(Tree : BST) return Boolean;

    -- Add an element to the tree.
    -- If the element already exists in the tree, throw
    -- a Duplicate_Value exception and do not change the tree.
    -- Your tree should not allow duplicate values.
    procedure add(Item : ItemType; Tree : in out BST);

    -- Remove the given Item from the tree. If the item
    -- doesn't exist, throw a No_Such_Element exception
    procedure remove(Item : ItemType; Tree: in out BST);

    -- Return true if the tree contains the Item. 
    -- Otherwise, return false.
    -- The tree should not be modified.
    function contains(Item : ItemType; Tree : BST)
                      return Boolean;

    -- Perform an in-order traversal of the tree.
    -- Should use the provided generic procedure
    -- printItem().
    -- After printing each item, add an additional
    -- space.
    -- It is ok if there is a space after the last
    -- item.
    procedure printInSortedOrder(Tree : BST);
    
private
    type Node;
    type NodePtr is access Node;
    type Node is record
        Data : ItemType;
        Left, Right : NodePtr;
    end record;

    -- This type is technically different than NodePointer.
    -- However, you can convert between the two using 
    -- explicit conversion.
    -- To convert an instance "tree" of the BST type to a 
    --NodePointer, use NodePointer(tree);
    type BST is new NodePtr;
    
end bstpackage;
