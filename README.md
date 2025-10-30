\# **Smart Row Delete - Oracle APEX Plugin**

A powerful and easy-to-use Oracle APEX Dynamic Action plugin that enables seamless row deletion in Interactive Reports and Classic Reports with customizable confirmation dialogs, success/error messages, and smooth animations.  
Features

Easy Integration: Simple setup with minimal configuration  
Interactive & Classic Reports: Works with both report types  
Composite Primary Keys: Supports multiple primary key columns  
Customizable Messages: Configure success, error, and confirmation messages  
Visual Feedback: Smooth animations and loading indicators  
Automatic Refresh: Auto-refreshes the region after deletion  
Security: Built-in SQL injection prevention  
No Page Reload: AJAX-based deletion without full page refresh  
Flexible Icon Support: Use any Font Awesome icon for the delete action  

**Demo**
[View Demo](https://www.linkedin.com/posts/muhammad-sajid-0590a5120_oracleapex-lowcode-plugindevelopment-activity-7382403775245991936-9-X2?utm_source=share&utm_medium=member_desktop&rcm=ACoAAB3pzAUBkctXn1sXWVI2RXIA7A_YlmUTxco)

**Requirements**

Oracle APEX 23.1 or higher  
Oracle Database 11g or higher  
Font Awesome icons (included in APEX by default) 

**Installation**  
Method 1: Import Plugin File

Download the latest plugin file from Releases  
Navigate to Shared Components > Plugins  
Click Import and select the downloaded .sql file  
Follow the import wizard to complete installation

**Quick Start**  
**Step 1**: Prepare Your Report Query  
Add a delete action column to your SQL query:  
SELECT   
    EMP_ID,  
    EMP_NAME,  
    DEPARTMENT,  
    SALARY,  
    '<span class="delete-icon fa fa-trash-o"   
           data-emp_id="' || EMP_ID || '"></span>' AS DELETE_ACTION  
FROM EMPLOYEES  
For Composite Primary Keys:  
SELECT   
    CPT_ID,  
    TEST_ID,  
    PARAMETER_ID,  
    ACTIVE,  
    '<span class="delete-icon fa fa-trash-o"   
           data-cpt_id="' || CPT_ID || '"   
           data-test_id="' || TEST_ID || '"   
           data-parameter_id="' || PARAMETER_ID || '"></span>' AS DELETE_ACTION  
FROM COMMENTS_TEST_PARAMETER  
**Step 2**: Configure Report Column

Edit the DELETE_ACTION column  
Set Type to Display as Text  
Set Escape Special Characters to No  
Optionally, set column heading to an icon: <span class="fa fa-trash"></span>

**Step 3**: Create Dynamic Action

Create a new Dynamic Action on Page Load  
Optionally, Set Event Scope to Dynamic  
Action: Select Smart Row Delete from the plugin list  
Configure Plugin Settings: 

Table Name: EMPLOYEES (or your table name)  
Primary Key Column(s): EMP_ID (use colon : for multiple: CPT_ID:TEST_ID:PARAMETER_ID)  
Region Static ID: Your report region's static ID (e.g., employee_report)  
Success Message: Record deleted successfully (optional)  
Error Message: Error deleting record (optional)  
Confirmation Message: Are you sure you want to delete this record? (optional)  
Show Confirmation: Yes (optional)  
Delete Icon Class: fa-trash-o (default, optional)  
Icon CSS Class: delete-icon (default, optional)

**Step 4**: Set Region Static ID.


\## **Star**

If you find this plugin useful, please consider giving it a star ⭐



---



\*\*Made with ❤️ for the Oracle APEX Community\*\*

