# Simple Contact List

A contact list application: 
- tracks contacts
  - names, phone numbers
  - email addresses. 

- Layout
  - if success message has been set, display it
- View all contacts (name only)
  - links
    - create
    - delete
  - get
  - erb
- View specific contact (name, email, address)
  - links
    - edit
  - get
  - erb
- Create a contact
  - get
  - form - post
    - success - redirect to view all
    - failure - show error
- Edit a contact
  - get
  - form - post
    - success - redirect to view all
    - failure - show error
- Remove a contact
  - post
- Communicate various messages (success, failure, etc.)

- how to store or persist data?
  - YAML file 

Nice-to-have
- User logins, associated with specific data. One YAML, nested
- Assign contacts to categories (friends, family, work, etc)
  - Two views
    - Alphabetical


Data structure
- contact
  - phone
  - email
  - address
  - category

- user
  - contact 1
    - phone
    - ...
    - category
  - contact 2