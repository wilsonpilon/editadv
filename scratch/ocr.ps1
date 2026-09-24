param(
    [string]$ImagePath
)

Add-Type -AssemblyName System.Runtime.WindowsRuntime
$null = [Windows.Storage.StorageFile, Windows.Storage, ContentType = WindowsRuntime]
$null = [Windows.Media.Ocr.OcrEngine, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime]
$null = [Windows.Graphics.Imaging.BitmapDecoder, Windows.Foundation.UniversalApiContract, ContentType = WindowsRuntime]

function AwaitAction($asyncOp) {
    $asyncOpType = $asyncOp.GetType()
    $asTaskGeneric = [System.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { 
        $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.IsGenericMethod 
    } | Select-Object -First 1
    $task = $asTaskGeneric.MakeGenericMethod($asyncOpType.GetGenericArguments()[0]).Invoke($null, @($asyncOp))
    $task.Wait()
    return $task.Result
}

$absPath = (Resolve-Path $ImagePath).Path
$file = AwaitAction ([Windows.Storage.StorageFile]::GetFileFromPathAsync($absPath))
$stream = AwaitAction ($file.OpenAsync([Windows.Storage.FileAccessMode]::Read))
$decoder = AwaitAction ([Windows.Graphics.Imaging.BitmapDecoder]::CreateAsync($stream))
$bitmap = AwaitAction ($decoder.GetSoftwareBitmapAsync())

$engine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromUserProfileLanguages()
if ($null -eq $engine) {
    $engine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage([Windows.Globalization.Language]::new('pt-BR'))
}
if ($null -eq $engine) {
    $engine = [Windows.Media.Ocr.OcrEngine]::TryCreateFromLanguage([Windows.Globalization.Language]::new('en-US'))
}

$ocrResult = AwaitAction ($engine.RecognizeAsync($bitmap))
$ocrResult.Text
