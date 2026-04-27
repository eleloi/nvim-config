return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "leoluz/nvim-dap-go",
        "theHamsta/nvim-dap-virtual-text", -- Modern addition for inline values
    },
    keys = {
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Toggle Breakpoint",
        },
        {
            "<leader>dc",
            function()
                require("dap").continue()
            end,
            desc = "Continue/Start",
        },
        {
            "<leader>di",
            function()
                require("dap").step_into()
            end,
            desc = "Step Into",
        },
        {
            "<leader>dn",
            function()
                require("dap").step_over()
            end,
            desc = "Step Over",
        },
        {
            "<leader>do",
            function()
                require("dap").step_out()
            end,
            desc = "Step Out",
        },
        {
            "<leader>du",
            function()
                require("dapui").toggle()
            end,
            desc = "Toggle UI",
        },
        {
            "<leader>dt",
            function()
                require("dap-go").debug_test()
            end,
            desc = "Debug Go Test",
        },
        {
            "<leader>dl",
            function()
                require("dap-go").debug_last_test()
            end,
            desc = "Debug Last Go Test",
        },
        {
            "<leader>dq",
            function()
                require("dap").terminate()
            end,
            desc = "Quit Debug Session",
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()
        require("dap-go").setup({
            env = {
                CGO_CPPFLAGS = "-U_FORTIFY_SOURCE",
            },
            dap_configurations = {
                {
                    type = "go",
                    name = "Debug",
                    request = "launch",
                    program = "${file}",
                    env = {
                        CGO_CPPFLAGS = "-U_FORTIFY_SOURCE",
                    },
                },
                {
                    type = "go",
                    name = "Debug test", -- configuration for debugging test files
                    request = "launch",
                    mode = "test",
                    program = "${file}",
                    env = {
                        CGO_CPPFLAGS = "-U_FORTIFY_SOURCE",
                    },
                },
            },
        })
        require("nvim-dap-virtual-text").setup()

        -- Auto open/close UI
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
}
