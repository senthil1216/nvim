local status_ok, autoPairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end
autoPairs.setup()
