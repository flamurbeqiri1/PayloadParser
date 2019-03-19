# PayloadParser
A class with method parsing the response data (generic response and result)


Where:
• data: The data returned by the server
• error: An error object that indicates why the operation failed, or nil if the operation was
successful.

Return Value: JSON object for "payload" key, or nil if operation failed or the data is incorrect.
If data is correct and operation fails, the error's localized description should return the value
for "message" key of the JSON object. Otherwise it should contain some meaningful, user
readable, description.
