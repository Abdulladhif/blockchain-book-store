// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface IERC20Token {
    function transfer(address, uint256) external returns (bool);
    function approve(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address, address) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Bookstore {

    uint internal booksLength = 0;
    address internal cUsdTokenAddress = 0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;

    struct Book {
        address payable owner;
        string name;
        string image;
        string description;
        string location;
        uint price;
        uint sold;
        string encryptedDownloadLink;
    }

    mapping (uint => Book) internal books;
    mapping (uint => mapping (address => bool)) internal bookBuyers;

    function writeBook(
        string memory _name,
        string memory _image,
        string memory _description, 
        string memory _location, 
        uint _price,
        string memory _encryptedDownloadLink
    ) public {
        uint _sold = 0;
        books[booksLength] = Book(
            payable(msg.sender),
            _name,
            _image,
            _description,
            _location,
            _price,
            _sold,
            _encryptedDownloadLink
        );
        booksLength++;
    }

    function readBook(uint _index) public view returns (
        address payable,
        string memory, 
        string memory, 
        string memory, 
        string memory, 
        uint, 
        uint,
        string memory
    ) {
        Book memory book = books[_index];
        return (
            book.owner,
            book.name, 
            book.image, 
            book.description, 
            book.location, 
            book.price,
            book.sold,
            book.encryptedDownloadLink
        );
    }
    
    function buyBook(uint _index) public {
        require(
            IERC20Token(cUsdTokenAddress).transferFrom(
                msg.sender,
                books[_index].owner,
                books[_index].price
            ),
            "Transfer failed."
        );
        books[_index].sold++;
        bookBuyers[_index][msg.sender] = true;
    }
    
    function getBooksLength() public view returns (uint) {
        return booksLength;
    }

    function getEncryptedDownloadLink(uint _index) public view returns (string memory) {
        require(bookBuyers[_index][msg.sender], "You have not purchased this book.");
        return books[_index].encryptedDownloadLink;
    }
}
