require('neorg').setup({
  load = {
    ['core.defaults'] = {},
    ['core.norg.dirman'] = {
      config = {
        workspaces = {
          work = '~/Programming/notes',
          gtd = '~/Programming/gtd',
        },
      },
    },
    ['core.norg.journal'] = {
      config = {
        workspace = 'work',
      },
    },
    ['core.norg.concealer'] = {
      config = {},
    },
    ['core.gtd.base'] = {
      config = {
        workspace = 'gtd',
      },
    },
  },
})
