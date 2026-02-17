require("sessions").setup({
    events = { "WinEnter","WinResized","WinLeave","WinClosed","WinNew"},
    session_filepath = Basepath .. "/.sessions",
    absolute = true,
})
