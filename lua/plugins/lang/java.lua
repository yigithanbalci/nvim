--TODO: update this file for java projects
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "java" },
    },
  },
  {
    "nvim-java/nvim-java",
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            jdtls = {
              settings = {
                java = {
                  configuration = {
                    runtimes = {
                      {
                        name = "JavaSE-23",
                        path = "/usr/bin/java",
                      },
                    },
                  },
                },
              },
            },
          },
          setup = {
            jdtls = function(_, opts)
              require("java").setup({
                spring_boot_tools = {
                  enable = true,
                  version = "1.59.0",
                },
                java_test = {
                  enable = true,
                  version = "0.43.0",
                },
                jdk = {
                  auto_install = false,
                  version = "23.0.2",
                },
                root_markers = {
                  "settings.gradle",
                  "settings.gradle.kts",
                  "pom.xml",
                  "build.gradle",
                  "mvnw",
                  "gradlew",
                  "build.gradle",
                  "build.gradle.kts",
                },
              })
              return opts
            end,
          },
        },
      },
    },
  },
}
