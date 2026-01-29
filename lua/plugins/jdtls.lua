return {
  'mfussenegger/nvim-jdtls',
  dependencies = {
    -- Autocompletion
    {'hrsh7th/cmp-nvim-lsp'},
  },
  config = function()
    local java_cmds = vim.api.nvim_create_augroup("java_cmds", {clear = true})
    local cache_vars = {}

    local function get_jdtls_paths()
        if cache_vars.paths then
            return cache_vars.paths
        end

        local path = {}

        path.data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"

        local jdtls_install = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
        if vim.fn.isdirectory(jdtls_install) == 0 then
            vim.notify("jdtls not installed via Mason. Run :MasonInstall jdtls", vim.log.levels.WARN)
            return nil
        end

        path.java_agent = jdtls_install .. "/lombok.jar"
        path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

        if vim.fn.has("mac") == 1 then
            path.platform_config = jdtls_install .. "/config_mac"
        elseif vim.fn.has("unix") == 1 then
            path.platform_config = jdtls_install .. "/config_linux"
        elseif vim.fn.has("win32") == 1 then
            path.platform_config = jdtls_install .. "/config_win"
        end

        path.runtimes = {
            {
                name = "JavaSE-21",
                path = "/usr/lib/jvm/java-21-amazon-corretto",
            },
        }

        cache_vars.paths = path

        return path
    end

    local function jdtls_on_attach(client, bufnr)
        local opts = {buffer = bufnr}
        require("jdtls").setup_dap {
            config_overrides = {
                vmArgs = '-ea -javaagent:/local/home/lukerry/.local/share/nvim/mason/packages/jdtls/lombok.jar',
            },
            hotcodereplace = "auto"
        }
        require("jdtls.dap").setup_dap_main_class_configs()
    end

    local function jdtls_setup(event)
        local jdtls = require("jdtls")

        local path = get_jdtls_paths()
        if not path then return end
        local data_dir = path.data_dir .. "/" ..  vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

        if cache_vars.capabilities == nil then
            jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

            local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
            cache_vars.capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            ok_cmp and cmp_lsp.default_capabilities() or {}
            )
        end

        local cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-javaagent:" .. path.java_agent,
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar", path.launcher_jar,
            "-configuration", path.platform_config,
            "-data", data_dir,
        }

        local lsp_settings = {
            java = {
                eclipse = {
                    downloadSources = true,
                },
                configuration = {
                    runtimes = path.runtimes,
                },
                maven = {
                    downloadSources = true,
                },
                inlayHints = {
                    parameterNames = {
                        enabled = "all",
                    }
                },
                format = {
                    enabled = true,
                }
            },
            signatureHelp = {
                enabled = true,
            },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
            },
            contentProvider = {
                preferred = "fernflower",
            },
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                }
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
        }

        -- used for java debugging
        local bundles = {
            vim.fn.glob("~/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
        }
        vim.list_extend(bundles, vim.split(vim.fn.glob("~/.config/nvim/vscode-java-test/server/*.jar", 1), "\n"))

        jdtls.start_or_attach({
            cmd = cmd,
            settings = lsp_settings,
            on_attach = jdtls_on_attach,
            capabilities = cache_vars.capabilities,
            root_dir = jdtls.setup.find_root({ "packageInfo" }, "Config"),
            flags = {
                allow_incremental_sync = true,
            },
            init_options = {
                bundles = bundles
            },
        })
    end

    vim.api.nvim_create_autocmd("FileType", {
        group = java_cmds,
        pattern = {"java"},
        desc = "Setup jdtls",
        callback = jdtls_setup,
    })
  end
}
