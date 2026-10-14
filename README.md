# TPG226C Group Project Checklist  
*Based on the project description retrieved from Blackboard (TPG226C_2026_TESTNO3_GROUP_PROJECT.docx)*  

---  

## ✅ Group Administration  
- [ ] Group size: **minimum 5, maximum 10 members**  
- [ ] Document each member’s **student number and name** (in submission document and as comments in Dart source files)  
- **Communication status (14 October 2026):** LK Radebe (221009560), NN Jonathan (224028270), and Ndlovu B (224098702) have remained in contact. The remaining group members have not responded to recent communications, and the group has been unable to reach them for an extended period.

## ✅ Application Overview  
- [x] Build a **Flutter Retail Inventory Management App** for SmartMart Retailers  
- [x] Store product data locally in a plain text file (`products.txt`); **no database** permitted  
- [x] Use only Flutter/Dart concepts covered in the module (no extra packages required)  

## ✅ Functional Requirements  

### 1. Home Screen – Product List  
- [x] Use `ListView.builder` to display all saved products  
- [x] Each product shown inside a **Card** or `ListTile`  
- [x] **Leading widget**: `CircleAvatar` displaying the product image  
- [x] **Title**: product name  
- [x] **Subtitle**: product code and unit price (e.g., `PRD001 – $24.99`)  
- [x] **Trailing area**: current stock status (e.g., `Available`, `Low Stock`, `Out of Stock`)  
- [x] **FloatingActionButton (FAB)**: navigates to the **Add Product** screen  
- [x] **Tap on a product**: navigates to the **Product Detail** screen  
- [x] **Long‑press on a product**: shows a confirmation dialog before deletion  

### 2. Product Detail Screen  
- [x] Display complete details of the selected product (including image)  
- [x] Use suitable layout widgets (`Column`, `Row`, `Text`, `SizedBox`, `Divider`, `Card`)  
- [x] **Edit button**: opens the Add/Edit Product screen with existing values pre‑loaded  
- [x] **Delete button**: asks for confirmation before removing the product  

### 3. Add / Edit Product Screen  
- [x] Use a `Form` with the following input controls:  
  - **Product Code** – `TextFormField`  
  - **Product Name** – `TextFormField`  
  - **Category** – `DropdownButtonFormField` (suggested: Beverages, Groceries, Bakery, Dairy, Household, Personal Care, Electronics, Other)  
  - **Unit Price** – `TextFormField` with numeric keyboard  
  - **Quantity in Stock** – `TextFormField` with numeric input  
  - **Status** – `DropdownButtonFormField` (suggested: Available, Low Stock, Out of Stock)  
  - **Product Image** – reference to a local image stored in the `assets/` folder  
- [x] **Save** and **Cancel** buttons  

### 4. Form Validation  
- [x] **Product Code** must not be empty  
- [x] **Product Name** must not be empty  
- [x] **Unit Price** must be numeric and **greater than zero**  
- [x] **Quantity** must be an integer and **may not be negative**  
- [x] Display appropriate validation messages when input is invalid  

### 5. Add, Edit and Delete Operations  
- [x] **Adding**:   
  1. Validate the form   
  2. Create a `Product` object   
  3. Add it to the collection   
  4. Save the updated data to `products.txt`   
  5. Refresh the product list   
- [x] **Editing**:   
  1. Load the selected product into the form   
  2. Allow changes   
  3. Validate the new values   
  4. Update the product   
  5. Rewrite `products.txt`   
  6. Refresh the list   
- [x] **Deleting**:   
  1. Show an `AlertDialog` for confirmation   
  2. Remove the product only after confirmation   
  3. Update `products.txt`   
  4. Refresh the list   

### 6. Data Persistence Requirements  
- [x] Use `dart:io` for file operations  
- [x] Create a text file named **`products.txt`** in the app’s local directory  
- [x] Store **one product per line** using comma‑separated values:   
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
- [x] On app start:   
  - If `products.txt` exists → read all records and populate the product list   
  - If it does **not** exist → create the file and start with an empty list   
- [x] Whenever a product is added, edited, or deleted → rewrite `products.txt` to reflect the current set of records  

### 7. Product Model  
- [x] Create a **`Product` class** with at least the following properties:   
  - product code   
  - product name   
  - category   
  - price   
  - quantity   
  - image (path or asset reference)   
  - status   
- [x] Provide an appropriate constructor to initialize product objects  

### 8. Navigation  
- [x] Delete operations (from Product List **or** Product Detail screen) must first display a confirmation dialog  

### 9. Minimum Sample Data  
- [x] The submitted application must contain **at least five sample product records** for demonstration and testing  

## ✅ Expected Deliverables  
- [ ] Complete Flutter project source code submitted as a ZIP file  
- [x] A **sample `products.txt`** file containing ≥ 5 records  
- [x] All **local product images** used by the app placed in the correct `assets/` folder  
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
- [x] The app runs **without compilation errors**  
- [x] At least **five products** are available for testing  
- [x] **Add, edit, view, and delete** features all work correctly  
- [x] Invalid form input is handled using **validation messages**  
- [x] `products.txt` is **read when the app starts**  
- [x] `products.txt` is **updated after changes**  
- [x] All images **display correctly**  
- [ ] All required **screenshots are included**  
- [ ] The Flutter project has been **zipped for submission**  
- [ ] Every group member is **prepared to participate** in the demonstration  

---  

*Tick each box as you complete the corresponding item. When all boxes are checked, your group should be ready for submission and demonstration.*  
