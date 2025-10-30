\# Smart Row Delete - Oracle APEX Plugin



\[!\[APEX Version](https://img.shields.io/badge/APEX-19.2%2B-blue.svg)](https://apex.oracle.com)

\[!\[License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

\[!\[PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)



A powerful and easy-to-use Oracle APEX Dynamic Action plugin that enables seamless row deletion in Interactive Reports and Classic Reports with customizable confirmation dialogs, success/error messages, and smooth animations.



\## Features



\- \*\*Easy Integration\*\*: Simple setup with minimal configuration

\- \*\*Interactive \& Classic Reports\*\*: Works with both report types

\- \*\*Composite Primary Keys\*\*: Supports multiple primary key columns

\- \*\*Customizable Messages\*\*: Configure success, error, and confirmation messages

\- \*\*Visual Feedback\*\*: Smooth animations and loading indicators

\- \*\*Automatic Refresh\*\*: Auto-refreshes the region after deletion

\- \*\*Security\*\*: Built-in SQL injection prevention

\- \*\*No Page Reload\*\*: AJAX-based deletion without full page refresh

\- \*\*Flexible Icon Support\*\*: Use any Font Awesome icon for the delete action



\## Demo



!\[Smart Row Delete Demo](docs/screenshots/demo.gif)



\## Requirements



\- Oracle APEX 19.2 or higher

\- Oracle Database 11g or higher

\- Font Awesome icons (included in APEX by default)



\## Installation



\### Method 1: Import Plugin File



1\. Download the latest plugin file from \[Releases](../../releases)

2\. Navigate to \*\*Shared Components\*\* > \*\*Plugins\*\*

3\. Click \*\*Import\*\* and select the downloaded `.sql` file

4\. Follow the import wizard to complete installation



\### Method 2: Manual SQL Installation



```sql

-- Execute the plugin SQL file in your workspace

@dynamic\_action\_plugin\_smart\_row\_delete.sql

```



For detailed installation instructions, see \[Installation Guide](docs/installation.md).



\## Quick Start



\### Step 1: Prepare Your Report Query



Add a delete action column to your SQL query:



```sql

SELECT 

&nbsp;   EMP\_ID,

&nbsp;   EMP\_NAME,

&nbsp;   DEPARTMENT,

&nbsp;   SALARY,

&nbsp;   '<span class="delete-icon fa fa-trash-o" 

&nbsp;          data-emp\_id="' || EMP\_ID || '"></span>' AS DELETE\_ACTION

FROM EMPLOYEES

```



\*\*For Composite Primary Keys:\*\*



```sql

SELECT 

&nbsp;   CPT\_ID,

&nbsp;   TEST\_ID,

&nbsp;   PARAMETER\_ID,

&nbsp;   ACTIVE,

&nbsp;   '<span class="delete-icon fa fa-trash-o" 

&nbsp;          data-cpt\_id="' || CPT\_ID || '" 

&nbsp;          data-test\_id="' || TEST\_ID || '" 

&nbsp;          data-parameter\_id="' || PARAMETER\_ID || '"></span>' AS DELETE\_ACTION

FROM PATHOLOGY.COMMENTS\_TEST\_PARAMETER

```



\### Step 2: Configure Report Column



1\. Edit the `DELETE\_ACTION` column

2\. Set \*\*Type\*\* to `Display as Text (based on LOV, does not save state)`

3\. Set \*\*Escape Special Characters\*\* to `No`

4\. Optionally, set column heading to an icon: `<span class="fa fa-trash"></span>`



\### Step 3: Create Dynamic Action



1\. Create a new \*\*Dynamic Action\*\* on \*\*Page Load\*\*

2\. Set \*\*Event Scope\*\* to `Dynamic`

3\. \*\*Action\*\*: Select \*\*Smart Row Delete\*\* from the plugin list

4\. \*\*Configure Plugin Settings\*\*:

&nbsp;  - \*\*Table Name\*\*: `EMPLOYEES` (or your table name)

&nbsp;  - \*\*Primary Key Column(s)\*\*: `EMP\_ID` (use colon `:` for multiple: `CPT\_ID:TEST\_ID:PARAMETER\_ID`)

&nbsp;  - \*\*Region Static ID\*\*: Your report region's static ID (e.g., `employee\_report`)

&nbsp;  - \*\*Success Message\*\*: `Record deleted successfully` (optional)

&nbsp;  - \*\*Error Message\*\*: `Error deleting record` (optional)

&nbsp;  - \*\*Confirmation Message\*\*: `Are you sure you want to delete this record?` (optional)

&nbsp;  - \*\*Show Confirmation\*\*: `Yes` (optional)

&nbsp;  - \*\*Delete Icon Class\*\*: `fa-trash-o` (default, optional)

&nbsp;  - \*\*Icon CSS Class\*\*: `delete-icon` (default, optional)



\### Step 4: Set Region Static ID



1\. Edit your report region

2\. Go to \*\*Advanced\*\* section

3\. Set \*\*Static ID\*\* (e.g., `employee\_report`)



\## Configuration Guide



\### Plugin Attributes



| Attribute | Required | Description | Example |

|-----------|----------|-------------|---------|

| Table Name | Yes | Database table name | `EMPLOYEES` |

| Primary Key Column(s) | Yes | PK columns (colon-separated) | `EMP\_ID` or `ID:TYPE` |

| Region Static ID | Yes | Static ID of the report region | `employee\_report` |

| Success Message | No | Message on successful delete | `Record deleted successfully` |

| Error Message | No | Message on error | `Error deleting record` |

| Confirmation Message | No | Confirmation dialog text | `Are you sure?` |

| Show Confirmation | No | Display confirmation dialog | `Yes` / `No` |

| Delete Icon | No | Font Awesome icon class | `fa-trash-o` |

| Icon Class | No | CSS class for icon | `delete-icon` |



\### Advanced Configuration



For detailed configuration options and advanced use cases, see \[Configuration Guide](docs/configuration.md).



\## Examples



\### Example 1: Simple Single Primary Key



```sql

SELECT 

&nbsp;   CUSTOMER\_ID,

&nbsp;   CUSTOMER\_NAME,

&nbsp;   EMAIL,

&nbsp;   '<span class="delete-icon fa fa-trash-o" 

&nbsp;          data-customer\_id="' || CUSTOMER\_ID || '"></span>' AS DELETE

FROM CUSTOMERS

```



\*\*Plugin Settings:\*\*

\- Table Name: `CUSTOMERS`

\- Primary Key: `CUSTOMER\_ID`



\### Example 2: Composite Primary Key



```sql

SELECT 

&nbsp;   ORDER\_ID,

&nbsp;   ITEM\_ID,

&nbsp;   QUANTITY,

&nbsp;   '<span class="delete-icon fa fa-trash-o" 

&nbsp;          data-order\_id="' || ORDER\_ID || '" 

&nbsp;          data-item\_id="' || ITEM\_ID || '"></span>' AS DELETE

FROM ORDER\_ITEMS

```



\*\*Plugin Settings:\*\*

\- Table Name: `ORDER\_ITEMS`

\- Primary Key: `ORDER\_ID:ITEM\_ID`



\### Example 3: Custom Icons and Messages



```sql

SELECT 

&nbsp;   TASK\_ID,

&nbsp;   TASK\_NAME,

&nbsp;   '<span class="delete-icon fa fa-times-circle" 

&nbsp;          data-task\_id="' || TASK\_ID || '"></span>' AS REMOVE

FROM TASKS

```



\*\*Plugin Settings:\*\*

\- Delete Icon: `fa-times-circle`

\- Success Message: `Task removed successfully!`

\- Confirmation Message: `Delete this task?`



More examples available in the \[examples/](examples/) directory.



\## Troubleshooting



\### Common Issues



\*\*Issue 1: Nothing happens when clicking delete icon\*\*

\- Verify Region Static ID is set correctly

\- Check browser console for JavaScript errors

\- Ensure Font Awesome is loaded



\*\*Issue 2: Error: "Region Static ID is required"\*\*

\- Set Static ID in region's Advanced properties

\- Match Static ID exactly in plugin settings



\*\*Issue 3: Wrong row is deleted\*\*

\- Verify data attributes in HTML match primary key columns exactly

\- Check column names are lowercase in data attributes: `data-emp\_id` not `data-EMP\_ID`



\*\*Issue 4: Region doesn't refresh\*\*

\- Ensure Region Static ID is correct

\- Check APEX version supports region refresh API



\### Debug Mode



Enable APEX debug mode to see detailed plugin execution logs:

1\. Add `?debug=YES` to your page URL

2\. Check debug output for plugin execution details



\## Security Considerations



The plugin includes built-in security features:



\- \*\*SQL Injection Prevention\*\*: Column and table names are validated with regex

\- \*\*Bind Variables\*\*: Uses parameterized queries

\- \*\*Transaction Management\*\*: Automatic rollback on errors

\- \*\*Maximum PK Support\*\*: Limits composite keys to 8 columns



\*\*Important\*\*: Ensure users have appropriate database privileges for delete operations.



\## Browser Support



\- Chrome 90+

\- Firefox 88+

\- Safari 14+

\- Edge 90+



\## Contributing



Contributions are welcome! Please read \[CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.



\## Changelog



See \[CHANGELOG.md](CHANGELOG.md) for a list of changes and version history.



\## License



This project is licensed under the MIT License - see the \[LICENSE](LICENSE) file for details.



\## Support



\- \*\*Issues\*\*: \[GitHub Issues](../../issues)

\- \*\*Discussions\*\*: \[GitHub Discussions](../../discussions)

\- \*\*Documentation\*\*: \[Wiki](../../wiki)



\## Author



\*\*Your Name\*\*

\- GitHub: \[@yourusername](https://github.com/yourusername)

\- LinkedIn: \[Your Profile](https://linkedin.com/in/yourprofile)

\- Email: your.email@example.com



\## Acknowledgments



\- Oracle APEX Community

\- Font Awesome for icons

\- All contributors and users



\## Star History



If you find this plugin useful, please consider giving it a star ⭐



---



\*\*Made with ❤️ for the Oracle APEX Community\*\*

