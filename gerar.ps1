$ErrorActionPreference = "Stop"

# CONFIGURACAO
$Quantidade = 5

# Verifica o repositorio
git rev-parse --is-inside-work-tree
if ($LASTEXITCODE -ne 0) {
    throw "Esta pasta nao e um repositorio Git."
}

# Cria commits reais com alteracoes unicas
for ($i = 1; $i -le $Quantidade; $i++) {
    $data = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $arquivo = "registro.txt"

    Add-Content -Path $arquivo -Value "Registro $i - $data"

    git add $arquivo
    if ($LASTEXITCODE -ne 0) {
        throw "Falha ao adicionar arquivo."
    }

    git commit -m "chore: adiciona registro automatico $i"
    if ($LASTEXITCODE -ne 0) {
        throw "Falha ao criar commit."
    }
}

# Publica os commits
git push origin main
if ($LASTEXITCODE -ne 0) {
    throw "Falha ao enviar os commits."
}

Write-Host "Concluido: commits criados e enviados ao GitHub."