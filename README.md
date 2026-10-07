# TPG226C Group Project Checklist  
*Based on the project description retrieved from Blackboard (TPG226C_2026_TESTNO3_GROUP_PROJECT.docx)*  

---  

## ✅ Group Administration  
- [ ] Group size: **minimum 5, maximum 10 members**  
- [ ] Document each member’s **student number and name** (in submission document and as comments in Dart source files)  

## ✅ Application Overview  
- [ ] Build a **Flutter Retail Inventory Management App** for SmartMart Retailers  
- [ ] Store product data locally in a plain text file (`products.txt`); **no database** permitted  
- [ ] Use only Flutter/Dart concepts covered in the module (unless lecturer explicitly allows extra packages)  

## ✅ Functional Requirements  

### 1. Home Screen – Product List  
- [ ] Use `ListView.builder` to display all saved products  
- [ ] Each product shown inside a **Card** or `ListTile`  
- [ ] **Leading widget**: `CircleAvatar` displaying the product image  
- [ ] **Title**: product name  
- [ ] **Subtitle**: product code and unit price (e.g., `PRD001 – $24.99`)  
- [ ] **Trailing area**: current stock status (e.g., `Available`, `Low Stock`, `Out of Stock`)  
- [ ] **FloatingActionButton (FAB)**: navigates to the **Add Product** screen  
- [ ] **Tap on a product**: navigates to the **Product Detail** screen  
- [ ] **Long‑press on a product**: shows a confirmation dialog before deletion  

### 2. Product Detail Screen  
- [ ] Display complete details of the selected product (including image)  
- [ ] Use suitable layout widgets (`Column`, `Row`, `Text`, `SizedBox`, `Divider`, `Card`)  
- [ ] **Edit button**: opens the Add/Edit Product screen with existing values pre‑loaded  
- [ ] **Delete button**: asks for confirmation before removing the product  

### 3. Add / Edit Product Screen  
- [ ] Use a `Form` with the following input controls:  
  - **Product Code** – `TextFormField`  
  - **Product Name** – `TextFormField`  
  - **Category** – `DropdownButtonFormField` (suggested: Beverages, Groceries, Bakery, Dairy, Household, Personal Care, Electronics, Other)  
  - **Unit Price** – `TextFormField` with numeric keyboard  
  - **Quantity in Stock** – `TextFormField` with numeric input  
  - **Status** – `DropdownButtonFormField` (suggested: Available, Low Stock, Out of Stock)  
  - **Product Image** – reference to a local image stored in the `assets/` folder  
- [ ] **Save** and **Cancel** buttons  

### 4. Form Validation  
- [ ] **Product Code** must not be empty  
- [ ] **Product Name** must not be empty  
- [ ] **Unit Price** must be numeric and **greater than zero**  
- [ ] **Quantity** must be an integer and **may not be negative**  
- [ ] Display appropriate validation messages when input is invalid  

### 5. Add, Edit and Delete Operations  
- [ ] **Adding**:  
  1. Validate the form  
  2. Create a `Product` object  
  3. Add it to the collection  
  4. Save the updated data to `products.txt`  
  5. Refresh the product list  
- [ ] **Editing**:  
  1. Load the selected product into the form  
  2. Allow changes  
  3. Validate the new values  
  4. Update the product  
  5. Rewrite `products.txt`  
  6. Refresh the list  
- [ ] **Deleting**:  
  1. Show an `AlertDialog` for confirmation  
  2. Remove the product only after confirmation  
  3. Update `products.txt`  
  4. Refresh the list  

### 6. Data Persistence Requirements  
- [ ] Use `dart:io` for file operations  
- [ ] Create a text file named **`products.txt`** in the app’s local directory  
- [ ] Store **one product per line** using comma‑separated values:  
  ```
  ProductCode,ProductName,Category,Price,Quantity,Status
  ```  
  Example:  
  ```
  PRD001,Coca-Cola 2L,Beverages,24.99,35,Available
  PRD002,White Bread,Bakery,18.50,12,Available
  PRD003,Fresh Milk 2L,Dairy,32.99,4,Low Stock
  PRD004,Washing Powder 2kg,Household,79.99,0,Out of Stock
  PRD005,USB Keyboard,Electronics,199.99,8,Available
  ```  
- [ ] On app start:  
  - If `products.txt` exists → read all records and populate the product list  
  - If it does **not** exist → create the file and start with an empty list  
- [ ] Whenever a product is added, edited, or deleted → rewrite `products.txt` to reflect the current set of records  

### 7. Product Model  
- [ ] Create a **`Product` class** with at least the following properties:  
  - product code  
  - product name  
  - category  
  - price  
  - quantity  
  - image (path or asset reference)  
  - status  
- [ ] Provide an appropriate constructor to initialize product objects  

### 8. Navigation  
- [ ] Delete operations (from Product List **or** Product Detail screen) must first display a confirmation dialog  

### 9. Minimum Sample Data  
- [ ] The submitted application must contain **at least five sample product records** for demonstration and testing  

## ✅ Expected Deliverables  
- [ ] **Complete Flutter project source code** submitted as a ZIP file  
- [ ] A **sample `products.txt`** file containing ≥ 5 records  
- [ ] All **local product images** used by the app placed in the correct `assets/` folder  
- [ ] A short document listing the **names and student numbers** of all group members  
- [ ] **Screenshots** showing:  
  - Product List screen  
  - Product Detail screen  
  - Add/Edit form  
  - Delete confirmation dialog  
- [ ] A **working application** ready for practical demonstration  

## ✅ Practical Demonstration  
- [ ] Show that the app can:  
  1. Load existing data from `products.txt` on start‑up  
  2. Add a new product (with validation)  
  3. Edit an existing product  
  4. View product details  
  5. Delete a product with confirmation  
  6. Preserve changes through the local text file (i.e., data persists after restart)  
- [ ] Be prepared to explain how the application works, discuss code organization, and answer questions about functionality  

## ✅ Final Submission Checklist (from the spec)  
- [ ] The app runs **without compilation errors**  
- [ ] At least **five products** are available for testing  
- [ ] **Add, edit, view, and delete** features all work correctly  
- [ ] Invalid form input is handled using **validation messages**  
- [ ] `products.txt` is **read when the app starts**  
- [ ] `products.txt` is **updated after changes**  
- [ ] All images **display correctly**  
- [ ] All required **screenshots are included**  
- [ ] The Flutter project has been **zipped for submission**  
- [ ] Every group member is **prepared to participate** in the demonstration  

---  

*Tick each box as you complete the corresponding item. When all boxes are checked, your group should be ready for submission and demonstration.*