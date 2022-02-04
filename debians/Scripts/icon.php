<?php
$b64 = '';

if ( !function_exists ( 'file_get_contents' ) )
{
    function file_get_contents ( $file )
    {
        $fp = @fopen ( $file, 'rb' );
        if ( !$fp ) exit ( 'Unable to open ' . $file );
        $data = fread ( $fp, filesize ( $file ) );
        fclose ( $fp );
        return $data;
    }
}

if ( isset ( $_FILES['myfile'] ) )
{
    $b64 = base64_encode ( file_get_contents ( $_FILES['myfile']['tmp_name'] ) );
}
?>
<!doctype html public "-//W3C//DTD HTML 4.0 //EN">
<html>
<head>
       <title>Icon base64encode</title>
</head>
<body>
<form id="UploadForm" action="" method="post" enctype="multipart/form-data">
    Select icon file (GIF image): <input type="file" name="myfile" size="50" />
    <input type="submit" value="encode" />
    <?php if ( $b64 != '' ) : ?>
    <br /><br />
    <input type="text" size="120" value="<?=$b64?>" />
    <br /><br />
    Copy the encoded data from above and set it as an element of array $I in index.php. For example, if you
    have just encoded an icon for ".jpg" extension, you'd add this:<br />
    <strong style="color:blue;">$I['jpg']='&lt;PASTE ENCODED DATA HERE&gt;';</strong>
    <br /><br />
    If you want to use the same icon for many extensions, do something like this:<br />
    <strong style="color:blue;">$I['gif']=$I['jpg']=$I['png']='&lt;PASTE ENCODED DATA HERE&gt;';</strong>
    <br /><br />
    If an icon has already been set for an extension and you want to replace it, just encode the icon
    and paste the new encoded data between the quotes, don't do the step described above. It
    would still work but you would increase the size of the index.php file.
    <?php endif; ?>
</form>
</body>
</html>
