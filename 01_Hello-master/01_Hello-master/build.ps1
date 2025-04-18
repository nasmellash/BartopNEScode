<# NES Build Script #>
param([string]$Action = "build")

# CONFIGURE THESE 3 PATHS (must point to your .exe files)
$CC65 = "C:\cc65\bin\cc65.exe"    # ← Verify this path exists!
$CA65 = "C:\cc65\bin\ca65.exe"    # ← Verify this path exists!
$LD65 = "C:\cc65\bin\ld65.exe"    # ← Verify this path exists!

$Project = "hello"
$Config = "nrom_32k_vert.cfg"
$BuildDir = "BUILD"

function Build {
    # Create build folder
    if (-not (Test-Path $BuildDir)) { 
        New-Item -ItemType Directory -Path $BuildDir | Out-Null 
    }

    # Compilation steps
    & $CC65 -Oi "$Project.c" -o "$BuildDir\$Project.s"
    & $CA65 "$BuildDir\$Project.s" -o "$BuildDir\$Project.o"
    & $CA65 "crt0.s" -o "$BuildDir\crt0.o"
    & $LD65 -C $Config -o "$BuildDir\$Project.nes" "$BuildDir\crt0.o" "$BuildDir\$Project.o" nes.lib

    if (Test-Path "$BuildDir\$Project.nes") {
        Write-Host "✅ Build successful! Output: $BuildDir\$Project.nes" -ForegroundColor Green
    } else {
        Write-Host "❌ Build failed - check paths and source files" -ForegroundColor Red
    }
}

function Clean {
    Remove-Item "$BuildDir\*.nes", "$BuildDir\*.o", "$BuildDir\*.s" -ErrorAction SilentlyContinue
    Write-Host "🧹 Cleaned build files" -ForegroundColor Yellow
}

# Main execution
switch ($Action.ToLower()) {
    "clean" { Clean }
    default { Build }
}