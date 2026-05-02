# Fix specific wrong images
$imgDir = "C:\Users\ICT ADMIN\Desktop\Kova-Labs\images"

$fixes = @(
    @{
        File  = "screeniq-hero.jpg"
        Url   = "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1600&q=85&auto=format&fit=crop"
        Label = "Digital display screen in modern office/retail"
    },
    @{
        File  = "screeniq-retail.jpg"
        Url   = "https://images.unsplash.com/photo-1528697203577-37944f24e7f3?w=1200&q=85&auto=format&fit=crop"
        Label = "Digital display screen shopping center"
    },
    @{
        File  = "market-africa-tech.jpg"
        Url   = "https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=1600&q=85&auto=format&fit=crop"
        Label = "African professional using modern technology"
    },
    @{
        File  = "market-smb.jpg"
        Url   = "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=1200&q=85&auto=format&fit=crop"
        Label = "Small business owner mobile payment"
    },
    @{
        File  = "kovacard-hero.jpg"
        Url   = "https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=1600&q=85&auto=format&fit=crop"
        Label = "NFC contactless card close up"
    },
    @{
        File  = "about-founder.jpg"
        Url   = "https://images.unsplash.com/photo-1590086782957-93c06ef21604?w=1200&q=85&auto=format&fit=crop"
        Label = "Young African professional at laptop"
    }
)

Write-Host "Fixing images..." -ForegroundColor Cyan

foreach ($f in $fixes) {
    $dest = Join-Path $imgDir $f.File
    Write-Host "  Downloading: $($f.Label)" -ForegroundColor Yellow
    try {
        $client = New-Object System.Net.WebClient
        $client.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
        $client.Headers.Add("Referer", "https://unsplash.com/")
        $client.DownloadFile($f.Url, $dest)
        $client.Dispose()
        $kb = [math]::Round((Get-Item $dest).Length / 1KB)
        if ($kb -gt 20) {
            Write-Host "    OK - $($f.File) ($($kb)KB)" -ForegroundColor Green
        } else {
            Write-Host "    WARN: $($f.File) seems too small ($($kb)KB)" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "    FAIL: $_" -ForegroundColor Red
    }
}
Write-Host "Done." -ForegroundColor Cyan
