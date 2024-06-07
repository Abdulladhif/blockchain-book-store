const { expect } = require("chai");

describe("Bookstore contract", function () {
  it("Should write a book", async function () {
    const Bookstore = await ethers.getContractFactory("Bookstore");
    const bookstore = await Bookstore.deploy();

    // Define the book details
    // Define the book details
    const bookName = "nextjs cookbook";
    const bookImage = "file:///C:/Users/user/Downloads/nexts%20books/nextjs%20coock.jpg";
    const bookDescription = "Test Description";
    const bookLocation = "Test Location";
    const bookPrice = 100;
    const encryptedDownloadLink = "file:///C:/Users/user/Downloads/nexts%20books/Andrei%20Tazetdinov%20-%20Next.js%20Cookbook_%20Learn%20how%20to%20build%20scalable%20and%20high-performance%20apps%20from%20scratch%20(English%20Edition)-BPB%20Publications%20(2023).pdf";

    // Call the writeBook function
    await bookstore.writeBook(bookName, bookImage, bookDescription, bookLocation, bookPrice, encryptedDownloadLink);

    // Get the book data
    const book = await bookstore.books(0);

    // Check that the book data is correct
    expect(book.name).to.equal(bookName);
    expect(book.image).to.equal(bookImage);
    expect(book.description).to.equal(bookDescription);
    expect(book.location).to.equal(bookLocation);
    expect(book.price).to.equal(bookPrice);
    expect(book.encryptedDownloadLink).to.equal(encryptedDownloadLink);
  });
});