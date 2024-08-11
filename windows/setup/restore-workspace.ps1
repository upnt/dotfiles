$WorkSpaceDir = '~/workspace'
if ( -not ( Test-Path -Path $WorkSpaceDir ) ) {
    New-Item $GitSpaceDir -ItemType Directory
    gh auth login
    gh repo clone scholor
    gh repo clone upnt-zenn-contents
}
