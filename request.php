<?php  


function check($type, $requestType)
{
    switch ($requestType) {
        case "POST":
            if ($type == $requestType) {
                return true;
            } else {
                return false;
            }
    }
}

?>