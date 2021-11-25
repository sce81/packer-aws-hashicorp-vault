locals { 
    
    
    timestamp = regex_replace(timestamp(), "[- TZ:]", "") 

    ami_name = "${var.name}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
}

