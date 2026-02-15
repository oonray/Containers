require("sessions").setup({
    events = { "WinEnter","WinResized","WinLeave","WinClosed","WinNew"},
    session_filepath = os.getenv("HOME") .. "/sessions/",
    absolute = true,
})
