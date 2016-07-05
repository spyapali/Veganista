class BinaryNode(object):

    def __init__(self, data, left = None, right = None):
        self.left = left
        self.right = right
        self.data = data


class BinarySearchTree(object):

    def __init__(self, root):
        self.root = root

    def contains(self, sought):
        """Returns true/false if node is found within binary search tree"""

    if (self.root == sought):
        return True

    elif(current.data == sought):
        return True


    if (sought > current):
        contains(self, current.right)
    elif (sought < current):
        contains(self, current.left)

    return False

    left = contains(self, current.left)
    right = contains(self, current.right)


    def add(self, data):
        """Adds a node to the binary search tree"""

        current = self.root

        if sought < current:
            current = add(self, current.left)

        elif sought > current:
            current = add(self, current.right)


    def remove(self, sought):
        """removes a node from a binary search tree"""

        current =