## PHPSRV XAMPP Helper

This is a simple batch script to help us navigate multiple php projects using XAMPP.

We need to copy the phpsrv.bat file to C:\Windows\System32 folder. This will enable us to use the phpsrv command from the Command Prompt or Power Shell.

We also need to add the following change to our C:\xamp\htdocs\index.php file:
```php
    <?php
    if (!empty($_SERVER['HTTPS']) && ('on' == $_SERVER['HTTPS'])) {
        $uri = 'https://';
    } else {
        $uri = 'http://';
    }
	$uri .= $_SERVER['HTTP_HOST'];
    
    // custom dev folder
    header('Location: '.$uri.'/'. trim(fgets(fopen('activedir.txt', 'r'))) . '/');
    exit;
?>
```
We use ```php trim(fgets(fopen('activedir.txt', 'r'))) ``` to get the name of the active directory from the activedir.txt file, which will automatically be updated by the script.

The phpsrv script can be provided with an argument, and if the argument is an existing project, it will move us to its location, and also set the project as XAMPP's active directory, so we can access it using the localhost address only (in the browser).

Features to be added:
* An update where the script automatically updated the index.php file, so we don't need to mess around with editing it ourselves.
* Option to also open favorite code editor and web browser window on the side, both pointing at the active project.
* Error Checking

--- 

### Marian Oprisan
### Email: marian.razvan.oprisan@gmail.com