if ($(($args | Measure-Object).Count) -eq 0) {
    echo 'Provide at least one Python package name'
} else {
    Foreach ($name in $args) {
        pip install $name
        pip freeze | Select-String -Pattern $name -NoEmphasis -Raw >> requirements.txt
    }
}