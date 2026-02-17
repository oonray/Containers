require("sessions").setup({
    events = { "WinEnter","WinResized","WinLeave","WinClosed","WinNew"},
    session_filepath = Basepath .. "git/.sessions/",
    absolute = true,
})
