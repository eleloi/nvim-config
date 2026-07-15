local M = {}

M.setup = function()
  vim.pack.add({
    "https://github.com/nvim-orgmode/orgmode",
    "https://github.com/seflue/org-link.nvim",
    "https://github.com/nvim-orgmode/org-bullets.nvim",
  })

  require('orgmode').setup({
    org_agenda_files = '~/Documents/logseq/org/*.org',
    org_default_notes_file = '~/Documents/logseq/org/triage.org',
    -- org_hide_leading_stars = false,
    org_startup_indented = true,
    org_todo_keywords = { "TODO", "DOING", "WAITING", "BACKLOG", "|", "DONE" },
    org_agenda_custom_commands = {
      d = {
        description = 'Dashboard', -- Description shown in the prompt for the shortcut
        types = {
          {
            type = 'tags_todo',                       -- Type can be agenda | tags | tags_todo
            match = '+PRIORITY="A"|+TODO="DOING"',    --Same as providing a "Match:" for tags view <leader>oa + m, See: https://orgmode.org/manual/Matching-tags-and-properties.html
            org_agenda_overriding_header = 'High priority todos and doing',
            org_agenda_todo_ignore_deadlines = 'far', -- Ignore all deadlines that are too far in future (over org_deadline_warning_days). Possible values: all | near | far | past | future
          },
          {
            type = 'agenda',
            org_agenda_overriding_header = 'Daily agenda',
            org_agenda_span = 'day' -- can be any value as org_agenda_span
          },
          {
            type = 'tags',
            match = '-TODO="BACKLOG"',
            org_agenda_overriding_header = 'todos',
            -- org_agenda_category_filter_preset = 'todos', -- Show only headlines from `todos` category. Same value providad as when pressing `/` in the Agenda view
            org_agenda_todo_ignore_scheduled = 'all', -- Ignore all headlines that are scheduled. Possible values: past | future | all
          },
          {
            type = 'agenda',
            org_agenda_overriding_header = 'Whole week overview',
            org_agenda_span = 'week',        -- 'week' is default, so it's not necessary here, just an example
            org_agenda_start_on_weekday = 1, -- Start on Monday
            org_agenda_remove_tags = true    -- Do not show tags only for this view
          },
        }
      },
      p = {
        description = 'Personal agenda',
        types = {
          {
            type = 'tags_todo',
            org_agenda_overriding_header = 'My personal todos',
            org_agenda_category_filter_preset = 'todos',                       -- Show only headlines from `todos` category. Same value providad as when pressing `/` in the Agenda view
            org_agenda_sorting_strategy = { 'todo-state-up', 'priority-down' } -- See all options available on org_agenda_sorting_strategy
          },
          {
            type = 'agenda',
            org_agenda_overriding_header = 'Personal projects agenda',
            org_agenda_files = { '~/my-projects/**/*' }, -- Can define files outside of the default org_agenda_files
          },
          {
            type = 'tags',
            org_agenda_overriding_header = 'Personal projects notes',
            org_agenda_files = { '~/my-projects/**/*' },
            org_agenda_tag_filter_preset =
            'NOTES-REFACTOR' -- Show only headlines with NOTES tag that does not have a REFACTOR tag. Same value providad as when pressing `/` in the Agenda view
          },
        }
      }
    },
    org_capture_templates = {
      t = {
        description = "Task",
        template = "* TODO %?\n %U\n %a\n",
        target = "~/Documents/logseq/org/triage.org",
      },
      j = {
        description = "Journal",
        template = "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n",
        target = "~/Documents/logseq/org/journal.org",
        datetree = true,
      }
    }
  })

  require('org-bullets').setup({
    symbols = {
      checkboxes = {
        half = { "-", "@org.checkbox.halfchecked" },
        done = { "✅", "@org.keyword.done" },
        todo = { "🔳", "@org.keyword.todo" },
      },
    }
  })
  require("org-link").setup({})
end

return M
