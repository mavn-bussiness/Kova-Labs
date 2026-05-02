# Kova Labs - Stock Image Downloader
# Downloads free royalty-free images from Unsplash CDN (no API key required)
# Covers: Digital Signage, NFC/RFID, Fleet, HR, Mobile Money, Hospital Tech, Africa Business

$imgDir = Join-Path $PSScriptRoot "images"
if (!(Test-Path $imgDir)) {
    New-Item -ItemType Directory -Path $imgDir | Out-Null
    Write-Host "Created folder: $imgDir" -ForegroundColor Cyan
}

# ---------------------------------------------------------------
# Curated Unsplash photo IDs - free, royalty-free, high quality
# Format: https://images.unsplash.com/photo-{ID}?w=1600&q=85&auto=format&fit=crop
# ---------------------------------------------------------------
$images = @(

    # --- Hero / About ---
    @{
        File    = "hero-africa-city.jpg"
        Url     = "https://images.unsplash.com/photo-1611348586804-61bf6c080437?w=1920&q=85&auto=format&fit=crop"
        Caption = "African city skyline at night - Kampala/Nairobi"
    },
    @{
        File    = "about-founder.jpg"
        Url     = "https://images.unsplash.com/photo-1531482615713-2afd69097998?w=1200&q=85&auto=format&fit=crop"
        Caption = "African tech team working in modern office"
    },
    @{
        File    = "about-team.jpg"
        Url     = "https://images.unsplash.com/photo-1552664730-d307ca884978?w=1200&q=85&auto=format&fit=crop"
        Caption = "Business team collaboration"
    },

    # --- ScreenIQ (Digital Signage) ---
    @{
        File    = "screeniq-hero.jpg"
        Url     = "https://images.unsplash.com/photo-1504711434969-e33886168f5c?w=1600&q=85&auto=format&fit=crop"
        Caption = "Digital signage screen in airport/lobby"
    },
    @{
        File    = "screeniq-retail.jpg"
        Url     = "https://images.unsplash.com/photo-1567967455389-e432b929d33d?w=1200&q=85&auto=format&fit=crop"
        Caption = "Digital menu board in retail store"
    },
    @{
        File    = "screeniq-hospital.jpg"
        Url     = "https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?w=1200&q=85&auto=format&fit=crop"
        Caption = "Hospital reception with digital displays"
    },
    @{
        File    = "screeniq-bank.jpg"
        Url     = "https://images.unsplash.com/photo-1601597111158-2fceff292cdc?w=1200&q=85&auto=format&fit=crop"
        Caption = "Bank branch modern interior with screens"
    },

    # --- KovaCard (NFC / RFID) ---
    @{
        File    = "kovacard-nfc.jpg"
        Url     = "https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=1200&q=85&auto=format&fit=crop"
        Caption = "NFC contactless card payment"
    },
    @{
        File    = "kovacard-access.jpg"
        Url     = "https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=1200&q=85&auto=format&fit=crop"
        Caption = "Smart card access control reader"
    },
    @{
        File    = "kovacard-hospital-id.jpg"
        Url     = "https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=1200&q=85&auto=format&fit=crop"
        Caption = "Hospital staff ID and wristband system"
    },

    # --- TrackIQ (Fleet & Asset) ---
    @{
        File    = "trackiq-fleet.jpg"
        Url     = "https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?w=1200&q=85&auto=format&fit=crop"
        Caption = "Commercial vehicle fleet in Africa"
    },
    @{
        File    = "trackiq-dashboard.jpg"
        Url     = "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=1200&q=85&auto=format&fit=crop"
        Caption = "Analytics and tracking dashboard"
    },
    @{
        File    = "trackiq-gps.jpg"
        Url     = "https://images.unsplash.com/photo-1524661135-423995f22d0b?w=1200&q=85&auto=format&fit=crop"
        Caption = "GPS map navigation and tracking"
    },

    # --- StaffDesk (HR & Payroll) ---
    @{
        File    = "staffdesk-hr.jpg"
        Url     = "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=1200&q=85&auto=format&fit=crop"
        Caption = "HR professional in modern African office"
    },
    @{
        File    = "staffdesk-payroll.jpg"
        Url     = "https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=1200&q=85&auto=format&fit=crop"
        Caption = "Payroll and compliance documents"
    },

    # --- PayFlow (Mobile Money) ---
    @{
        File    = "payflow-momo.jpg"
        Url     = "https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=1200&q=85&auto=format&fit=crop"
        Caption = "Mobile money payment on smartphone"
    },
    @{
        File    = "payflow-fintech.jpg"
        Url     = "https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=1200&q=85&auto=format&fit=crop"
        Caption = "Fintech and digital payments Africa"
    },

    # --- InboxOS (Messaging) ---
    @{
        File    = "inboxos-chat.jpg"
        Url     = "https://images.unsplash.com/photo-1611746872915-64382b5c76da?w=1200&q=85&auto=format&fit=crop"
        Caption = "Unified messaging platform on screens"
    },

    # --- VaultDocs (Document Management) ---
    @{
        File    = "vaultdocs-office.jpg"
        Url     = "https://images.unsplash.com/photo-1568992687947-868a62a9f521?w=1200&q=85&auto=format&fit=crop"
        Caption = "Document management and office workflow"
    },

    # --- Market / Stats visuals ---
    @{
        File    = "market-africa-tech.jpg"
        Url     = "https://images.unsplash.com/photo-1589568322572-ff1c9f8b5dcd?w=1600&q=85&auto=format&fit=crop"
        Caption = "African tech entrepreneurs and startups"
    },
    @{
        File    = "market-smb.jpg"
        Url     = "https://images.unsplash.com/photo-1556742111-a301076d9d18?w=1200&q=85&auto=format&fit=crop"
        Caption = "Small business owner using software"
    }
)

Write-Host ""
Write-Host "Kova Labs - Downloading Stock Images from Unsplash" -ForegroundColor Green
Write-Host "----------------------------------------------------" -ForegroundColor DarkGray
Write-Host "Total: $($images.Count) images to download" -ForegroundColor Gray
Write-Host ""

$success = 0
$failed  = 0

foreach ($img in $images) {
    $dest = Join-Path $imgDir $img.File

    if ((Test-Path $dest) -and (Get-Item $dest).Length -gt 20000) {
        $kb = [math]::Round((Get-Item $dest).Length / 1KB)
        Write-Host "  [SKIP] $($img.File) ($($kb)KB - already exists)" -ForegroundColor DarkGray
        $success++
        continue
    }

    Write-Host "  [DL]   $($img.File)" -ForegroundColor Yellow
    Write-Host "         $($img.Caption)" -ForegroundColor DarkGray

    try {
        $wc = New-Object System.Net.WebClient
        $wc.Headers["User-Agent"]  = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
        $wc.Headers["Referer"]     = "https://unsplash.com/"
        $wc.DownloadFile($img.Url, $dest)
        $wc.Dispose()

        if ((Test-Path $dest) -and (Get-Item $dest).Length -gt 20000) {
            $kb = [math]::Round((Get-Item $dest).Length / 1KB)
            Write-Host "         OK  $($kb)KB" -ForegroundColor Green
            $success++
        } else {
            if (Test-Path $dest) { Remove-Item $dest }
            Write-Host "         FAIL: file too small" -ForegroundColor Red
            $failed++
        }
    } catch {
        Write-Host "         ERROR: $_" -ForegroundColor Red
        if (Test-Path $dest) { Remove-Item $dest }
        $failed++
    }

    Start-Sleep -Milliseconds 300   # polite rate limit
}

Write-Host ""
Write-Host "----------------------------------------------------" -ForegroundColor DarkGray
Write-Host "Done.  Success: $success   Failed: $failed" -ForegroundColor Cyan
Write-Host "Images saved to: $imgDir" -ForegroundColor Cyan

if ($failed -gt 0) {
    Write-Host ""
    Write-Host "Tip: Some images may have moved. Re-run the script" -ForegroundColor Yellow
    Write-Host "or replace failed URLs with new Unsplash photo IDs." -ForegroundColor Yellow
}
Write-Host ""
