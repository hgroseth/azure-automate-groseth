[CmdletBinding()]
param (
    # parameter er ikke obligatorisk siden vi har default verdi
    [Parameter(HelpMessage = "URL til kortstokk", Mandatory = $false)]
    [string]
    # når paramater ikke er gitt brukes default verdi
    $UrlKortstokk = 'http://nav-deckofcards.herokuapp.com/shuffle'
)
$ErrorActionPreference = 'Stop'



$webRequest = Invoke-WebRequest -Uri $UrlKortstokk

$kortstokkJson = $webRequest.Content

# se ./src/hints/kortstokk.json for formatert utgave

$kortstokk = ConvertFrom-Json -InputObject $kortstokkJson


# 1. utgave - foreach loop som skriver ut et kort per linje
foreach ($kort in $kortstokk) {
    Write-Output $kort
}

# 2. utgave - interessert i 1. karakter i merke - (S)PADE - og verdi
foreach ($kort in $kortstokk) {
    Write-Output "$($kort.suit[0])$($kort.value)"
}

# 3. utgave - ønsker egentlig hele kortstokken som en streng og den koden som en funksjon (gjenbruk)

function kortstokkTilStreng {
    [OutputType([string])]
    param (
        [object[]]
        $kortstokk
    )
    $streng = ""
    foreach ($kort in $kortstokk) {
        $streng = $streng + "$($kort.suit[0])" + $kort.value + ","
    }
    return $streng
}


Write-Output "Kortstokk: $(kortStokkTilStreng -kortstokk $kortstokk)"

