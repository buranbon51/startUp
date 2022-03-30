


libsup_GetDPI() {
/*
    RegRead, DPI_value, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, AppliedDPI
    return % (errorlevel = 1) ? 96
            : DPI_value
*/

    hDC := DllCall("GetDC", Int, 0)
    dpi := DllCall("GetDeviceCaps", UInt, hDC , UInt, 88)
    DllCall("ReleaseDC",Int, 0, UInt, hDC)

    return dpi ? dpi : 0
}
