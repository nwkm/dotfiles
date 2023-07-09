return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
		  "nvim-treesitter/nvim-treesitter",
		  "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
    },
    keys = {
      {
        "<leader>rl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>rL",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Debug Last Test",
      },
      {
        "<leader>rw",
        "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
        desc = "Run Watch",
      },
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
      table.insert(opts.adapters, require("neotest-vitest"))
    end,
    config = function()
      local present, neotest = pcall(require, "neotest")
      if not present then
        return
      end

      neotest.setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "npm test --",
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),
        },
        diagnostic = {
          enabled = false
        },
        floating = {
          border = nw.ui.float.border or "rounded",
          max_height = 0.6,
          max_width = 0.6
        },
        -- highlights = {
        --   adapter_name = "NeotestAdapterName",
        --   border = "NeotestBorder",
        --   dir = "NeotestDir",
        --   expand_marker = "NeotestExpandMarker",
        --   failed = "NeotestFailed",
        --   file = "NeotestFile",
        --   focused = "NeotestFocused",
        --   indent = "NeotestIndent",
        --   namespace = "NeotestNamespace",
        --   passed = "NeotestPassed",
        --   running = "NeotestRunning",
        --   skipped = "NeotestSkipped",
        --   test = "NeotestTest"
        -- },
        icons = {
          child_indent = "│",
          child_prefix = "├",
          collapsed = "─",
          expanded = "╮",
          failed = "✖",
          final_child_indent = " ",
          final_child_prefix = "╰",
          non_collapsible = "─",
          passed = "✔",
          running = "",
          skipped = "ﰸ",
          unknown = "?"
        },
        output = {
          enabled = true,
          open_on_run = true,
        },
        run = {
          enabled = true
        },
        status = {
          enabled = true
        },
        strategies = {
          integrated = {
            height = 40,
            width = 120
          }
        },
        summary = {
          enabled = true,
          expand_errors = true,
          follow = true,
          mappings = {
            attach = "a",
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            jumpto = "i",
            output = "o",
            run = "r",
            short = "O",
            stop = "u"
          }
        }
      })
    end,
  },
}
