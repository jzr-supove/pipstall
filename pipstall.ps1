if ($args.Length -eq 0) {
    echo "Provide at least one Python package name"
} 
elseif ($args.Length -eq 1 -and $args[0] -match '^-') {
    $cmd = $args[0]
    
    if ($cmd -match "^(-h)|(--help)$") {
        echo "Pipstall - Keep your package dependencies list clean`n"
        echo "Usage:"
        echo "    pipstall <package_name>"
        echo "    pipstall <package_name> <package_name> <package_name> ...`n"
        echo "Commands:"
        echo "    -r, --requirement     Installs dependencies from requirements.txt file"
        echo "    -p, --print           Prints contents of requirements.txt file"
        echo "    -h, --help            Prints this message`n"
        echo "Author: Jasur Yusupov"
    } 
    elseif ($cmd -match "^(-r)|(--requirement)$") {
        pip install -r requirements.txt
    }
    elseif ($cmd -match "^(-p)|(--print)$") {
        cat requirements.txt
    }
    else {
        echo "Unknown command"
    }
} 
else {
    Foreach ($name in $args) {
        pip install $name
        pip freeze | Select-String -Pattern $name -NoEmphasis -Raw | % {$_.replace("==", ">=")} >> requirements.txt
    }
}
