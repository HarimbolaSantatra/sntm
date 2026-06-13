print("SNTM is loaded !")

vim.api.nvim_create_user_command(
    'SNTM',
    require('sntm').health.health_check(),
    {}
)
